using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

//Translucency Baker
//v 1.0
//Fernando Pires

public class PixelInformation
{
    public int x;
    public int y;

    public int arrayIndex;

    public bool initialized = false;
    public Vector3[] currentIntensity;
    public Color[] currentEmission;

    public List<ReflectedCoordinate> reflections;

    public PixelInformation()
    {
        reflections = new List<ReflectedCoordinate>();
        currentIntensity = new Vector3[2] { Vector3.zero, Vector3.zero };
        currentEmission = new Color[2] { Color.black, Color.black };
    }
}
public struct ReflectedCoordinate
{
    public PixelInformation pixelInformation;
    public float distance;

    public ReflectedCoordinate(PixelInformation pixelInformation, float distance)
    {
        this.pixelInformation = pixelInformation;
        this.distance = distance;
    }
}

public class TranslucencyBaker : MonoBehaviour {

    private float sqrtThree = 1.73205080756887729f;
    public int textureResolution = 64;

    public bool bakeObjSpcTextures = true;
    public bool forceBakeIfExists = false;
    public bool objSpcSaveTextures = true;
    public int objSpcMultisample = 1;
    public int objSpcSpread = 1;

    public Texture2D objectSpacePosition;
    public Texture2D objectSpaceNormal;
    public Texture2D translucencyTexturePositive;
    public Texture2D translucencyTextureNegative;

    public bool saveTexture = true;

    //Material properties
    public float depthcutout = 0.1f;
    public float transparency = 0.95f;
    public float intensity = 1f;
    public float density = 100f;

    //Internal
    private Vector3[] totalLightBase = new Vector3[2];
    private Vector3[] totalLightFinal = new Vector3[2];
    public Vector3 debugV3 = new Vector3(1f, 1f, 1f);

	public void GenerateTranslucencyTexture () {

        totalLightBase[0] = Vector3.zero;
        totalLightBase[1] = Vector3.zero;

        #region BakeObjectSpaceTextures
        if (CheckBakeObjectSpaceTextures())
        {
            BakedTextures bakedTextures = (new ObjectSpaceBaker()).GenerateTextures(
                this.gameObject, textureResolution, objSpcMultisample, objSpcSpread, objSpcSaveTextures);
                objectSpacePosition = bakedTextures.tex2DObjectPos;
                objectSpaceNormal = bakedTextures.tex2DObjectNormal;
        }
        else if (objectSpacePosition == null || objectSpaceNormal == null)
        {
            return;
        }

        #endregion

        #region GetMaximumObjectSize
        Vector3 boundarySize = GetComponent<Renderer>().bounds.size;
        float objectSize = Mathf.Max(boundarySize.x, boundarySize.y, boundarySize.z);
        #endregion

        #region InitializeTextureObjectsInMemory
        Texture2D tex2DTranslucencyPositive = new Texture2D(textureResolution, textureResolution, TextureFormat.ARGB32, false);
        Texture2D tex2DTranslucencyNegative = new Texture2D(textureResolution, textureResolution, TextureFormat.ARGB32, false);
        tex2DTranslucencyPositive.filterMode = FilterMode.Bilinear;
        tex2DTranslucencyPositive.wrapMode = TextureWrapMode.Clamp;
        tex2DTranslucencyNegative.filterMode = FilterMode.Bilinear;
        tex2DTranslucencyNegative.wrapMode = TextureWrapMode.Clamp;
        Texture2D[] tex2DTranslucencyArray = new Texture2D[] { tex2DTranslucencyPositive, tex2DTranslucencyNegative };
        #endregion

        //This region initializes arrays for faster lookups
        #region StartObjectNormalAndPositionArrays
        Color[] osNormals = objectSpaceNormal.GetPixels();
        Color[] osPositions = objectSpacePosition.GetPixels();

        Color[] osNormalsPositive = GetAdjustedNormals(osNormals, 0);
        Color[] osNormalsNegative = GetAdjustedNormals(osNormals, 1);
        Color[][] osNormalArray = new Color[2][]{osNormalsPositive, osNormalsNegative};

        PixelInformation[][] pixels = new PixelInformation[textureResolution][];
        for (int i = 0; i < pixels.Length; i++)
        {
            pixels[i] = new PixelInformation[textureResolution];
            for (int j = 0; j < pixels[i].Length; j++)
            {
                pixels[i][j] = new PixelInformation();
            }
        }
        #endregion

        #region InitializePixelArray
        for (int x = 0; x < textureResolution; x++)
        {
            for (int y = 0; y < textureResolution; y++)
            {
                int arrIndex = x + y * textureResolution;

                //Checks if this pixel is mapped to a UV coord.
                if (osPositions[arrIndex].a >= 1f)
                {
                    pixels[x][y].initialized = true;
                    pixels[x][y].x = x;
                    pixels[x][y].y = y;
                    pixels[x][y].arrayIndex = arrIndex;
                    pixels[x][y].currentEmission[0] = osNormalArray[0][arrIndex];
                    pixels[x][y].currentEmission[1] = osNormalArray[1][arrIndex];

                    for (int xx = 0; xx < textureResolution; xx++)
                    {
                        for (int yy = 0; yy < textureResolution; yy++)
                        {
                            //We are now gonna map the distance between the pixel and every other pixel in the texture map.
                            //This saves processing time for multiple bounces.

                            int arrIndexB = xx + yy * textureResolution;
                                
                            //Object Space Map should NOT be normalized.
                            if (osPositions[arrIndexB].a >= 0.9f || arrIndexB == arrIndex)
                            {
                                float distance = 0f;
                                if (arrIndex == arrIndexB) { distance = 1f; }
                                else { distance = GetFullDistance(Distance(osPositions[arrIndex], osPositions[arrIndexB])); } //*objectsize
                                
                                //GetFullDistance already normalizes distance from 0 to 1 and considers depth cutout.
                                if (distance > 0f || arrIndex == arrIndexB)
                                {
                                    pixels[x][y].reflections.Add(new ReflectedCoordinate(pixels[xx][yy], distance));
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        #endregion

        #region InitializePixelList
        List<PixelInformation> pixelList = new List<PixelInformation>();
        for (int x = 0; x < textureResolution; x++)
        {
            for (int y = 0; y < textureResolution; y++)
            {
                if (pixels[x][y].initialized)
                {
                    pixelList.Add(pixels[x][y]);
                }
            }
        }
        pixels = new PixelInformation[0][];
        #endregion

        #region InitializeTranslucencyTexture
        //Gives them the base emission
        for (int x = 0; x < textureResolution; x++)
        {
            for (int y = 0; y < textureResolution; y++)
            {
                int arrIndex = x + y * textureResolution;
                tex2DTranslucencyPositive.SetPixel(x, y, osNormalArray[0][arrIndex] * (1f - transparency));
                tex2DTranslucencyNegative.SetPixel(x, y, osNormalArray[1][arrIndex] * (1f - transparency));
            }
        }
        tex2DTranslucencyPositive.Apply();
        tex2DTranslucencyNegative.Apply();
        #endregion

        #region CreateTranslucencyTexture
        GetBaseLightSum(pixelList);
        ScatterLight(pixelList);
        NormalizeLight(pixelList); //Energy conservation.

        BakeTranslucentTexture(pixelList, tex2DTranslucencyArray);
        SpreadPixels(osPositions, tex2DTranslucencyArray);

        if (saveTexture)
        {
            SaveTextures(gameObject.name, tex2DTranslucencyPositive, tex2DTranslucencyNegative);
        }
        #endregion

        translucencyTexturePositive = tex2DTranslucencyPositive;
        translucencyTextureNegative = tex2DTranslucencyNegative;

        
        GetComponent<Renderer>().sharedMaterial.SetTexture("_EmissionMap", tex2DTranslucencyPositive);
        GetComponent<Renderer>().sharedMaterial.SetColor("_MainColor", Color.black);
    }

    void GetBaseLightSum(List<PixelInformation> pixelList)
    {
        for (int i = 0; i < pixelList.Count; i++)
        {
            totalLightBase[0].x += pixelList[i].currentEmission[0].r;
            totalLightBase[0].y += pixelList[i].currentEmission[0].g;
            totalLightBase[0].z += pixelList[i].currentEmission[0].b;

            totalLightBase[1].x += pixelList[i].currentEmission[1].r;
            totalLightBase[1].y += pixelList[i].currentEmission[1].g;
            totalLightBase[1].z += pixelList[i].currentEmission[1].b;
        }
    }
    void ScatterLight(List<PixelInformation> pixelList)
    {
        float texSqr = textureResolution * textureResolution;
        for (int i = 0; i < pixelList.Count; i++)
        {
    
            Vector3 incomingLightPos = new Vector3(0f, 0f, 0f);
            Vector3 incomingLightNeg = new Vector3(0f, 0f, 0f);
            Vector3[] incomingLight = new Vector3[2] { incomingLightPos, incomingLightNeg };
            for (int j = 0; j < pixelList[i].reflections.Count; j++)
            {
                incomingLight[0].x += (pixelList[i].reflections[j].pixelInformation.currentEmission[0].r * pixelList[i].reflections[j].distance) / pixelList.Count;
                incomingLight[1].x += (pixelList[i].reflections[j].pixelInformation.currentEmission[1].r * pixelList[i].reflections[j].distance) / pixelList.Count;
                incomingLight[0].y += (pixelList[i].reflections[j].pixelInformation.currentEmission[0].g * pixelList[i].reflections[j].distance) / pixelList.Count;
                incomingLight[1].y += (pixelList[i].reflections[j].pixelInformation.currentEmission[1].g * pixelList[i].reflections[j].distance) / pixelList.Count;
                incomingLight[0].z += (pixelList[i].reflections[j].pixelInformation.currentEmission[0].b * pixelList[i].reflections[j].distance) / pixelList.Count;
                incomingLight[1].z += (pixelList[i].reflections[j].pixelInformation.currentEmission[1].b * pixelList[i].reflections[j].distance) / pixelList.Count;
            }
            pixelList[i].currentIntensity[0] += incomingLight[0];
            pixelList[i].currentIntensity[1] += incomingLight[1];
        }
    }
    void NormalizeLight(List<PixelInformation> pixelList)
    {
        totalLightFinal[0] = Vector3.zero;
        totalLightFinal[1] = Vector3.zero;

        for (int i = 0; i < pixelList.Count; i++)
        {
            totalLightFinal[0].x += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[0].x));
            totalLightFinal[0].y += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[0].y));
            totalLightFinal[0].z += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[0].z));

            totalLightFinal[1].x += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[1].x));
            totalLightFinal[1].y += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[1].y));
            totalLightFinal[1].z += Mathf.Max(0f, Mathf.Min(1f, pixelList[i].currentIntensity[1].z));
        }

        Vector3 totalLightFactorPos = new Vector3(totalLightBase[0].x / totalLightFinal[0].x,
            totalLightBase[0].y / totalLightFinal[0].y,
            totalLightBase[0].z / totalLightFinal[0].z);
        Vector3 totalLightFactorNeg = new Vector3(totalLightBase[1].x / totalLightFinal[1].x,
            totalLightBase[1].y / totalLightFinal[1].y,
            totalLightBase[1].z / totalLightFinal[1].z);


        for (int i = 0; i < pixelList.Count; i++)
        {
            pixelList[i].currentIntensity[0] = new Vector3(pixelList[i].currentIntensity[0].x * totalLightFactorPos.x,
                pixelList[i].currentIntensity[0].y * totalLightFactorPos.y,
                pixelList[i].currentIntensity[0].z * totalLightFactorPos.z);
            pixelList[i].currentIntensity[1] = new Vector3(pixelList[i].currentIntensity[1].x * totalLightFactorNeg.x,
                pixelList[i].currentIntensity[1].y * totalLightFactorNeg.y,
                pixelList[i].currentIntensity[1].z * totalLightFactorNeg.z);
        }
    }

    void BakeTranslucentTexture(List<PixelInformation> pixelList, Texture2D[] textureArray)
    {

        for (int i = 0; i < pixelList.Count; i++)
        {
            Color pixelPos = textureArray[0].GetPixel(pixelList[i].x, pixelList[i].y);
            Color pixelNeg = textureArray[1].GetPixel(pixelList[i].x, pixelList[i].y);
            textureArray[0].SetPixel(pixelList[i].x, pixelList[i].y,
                new Color(
                    (pixelPos.r + pixelList[i].currentIntensity[0].x * transparency * intensity) * debugV3.x,
                    (pixelPos.g + pixelList[i].currentIntensity[0].y * transparency * intensity) * debugV3.y,
                    (pixelPos.b + pixelList[i].currentIntensity[0].z * transparency * intensity) * debugV3.z, 1f));
            textureArray[1].SetPixel(pixelList[i].x, pixelList[i].y,
                new Color(
                    (pixelNeg.r + pixelList[i].currentIntensity[1].x * transparency * intensity) * debugV3.x,
                    (pixelNeg.g + pixelList[i].currentIntensity[1].y * transparency * intensity) * debugV3.y,
                    (pixelNeg.b + pixelList[i].currentIntensity[1].z * transparency * intensity) * debugV3.z, 1f));
        }
        textureArray[0].Apply();
        textureArray[1].Apply();
    }
    void SpreadPixels(Color[] osPositions, Texture2D[] textureArray)
    {
        Color32[] pixelsPos = textureArray[0].GetPixels32();
        Color32[] pixelsNeg = textureArray[1].GetPixels32();
        for (int i = 0; i < textureResolution; i++)
        {
            for (int j = 0; j < textureResolution; j++)
            {
                int arrayPos = i + j * textureResolution;
                if (osPositions[arrayPos].a < 0.9f)
                {
                    textureArray[0].SetPixel(i, j, new Color(1f,1f,1f));
                    Color32 pixelPos = pixelsPos[arrayPos];
                    Color32 pixelNeg = pixelsNeg[arrayPos];
                    Color32 newColorPos = Color.black;
                    Color32 newColorNeg = Color.black;
                    bool keepLooping = true;
                    for (int xx = -1; xx < 2; xx++)
                    {
                        if (!keepLooping) { break; }
                        for (int yy = -1; yy < 2; yy++)
                        {
                            if (xx != 0 || yy != 0)
                            {
                                int sumX = i + xx;
                                int sumY = j + yy;
                                if (sumX == -1)
                                {
                                    sumX = textureResolution - 1;
                                }
                                else if (sumX == textureResolution)
                                {
                                    sumX = 0;
                                }
                                if (sumY == -1)
                                {
                                    sumY = textureResolution - 1;
                                }
                                else if (sumY == textureResolution)
                                {
                                    sumY = 0;
                                }
                                if (sumX > 0 && sumX < textureResolution && sumY > 0 && sumY < textureResolution)
                                {
                                    int colorIndex = sumX + sumY * textureResolution;
                                    if (osPositions[colorIndex].a > 0.9f)
                                    {
                                        
                                        //keepLooping = false;
                                        Color32 colorPos = new Color32(pixelsPos[colorIndex].r, pixelsPos[colorIndex].g, pixelsPos[colorIndex].b, 128);
                                        if ((colorPos.r + colorPos.g + colorPos.b) > (newColorPos.r + newColorPos.g + newColorPos.b))
                                        {
                                            newColorPos = colorPos;
                                        }
                                        Color32 colorNeg = new Color32(pixelsNeg[colorIndex].r, pixelsNeg[colorIndex].g, pixelsNeg[colorIndex].b, 128);
                                        if ((colorNeg.r + colorNeg.g + colorNeg.b) > (newColorNeg.r + newColorNeg.g + newColorNeg.b))
                                        {
                                            newColorNeg = colorNeg;
                                        }
                                    }
                                }
                            }
                        }
                        textureArray[0].SetPixel(i, j, newColorPos);
                        textureArray[1].SetPixel(i, j, newColorNeg);
                    }
                }
            }
        }
            textureArray[0].Apply();
            textureArray[1].Apply();
    }

    float Distance(Color colorA, Color colorB)
    {
       float dd = Vector3.Distance(new Vector3(colorA.r, colorA.g, colorA.b), new Vector3(colorB.r, colorB.g, colorB.b));
        dd = dd / sqrtThree;
       return dd;
    }
    float GetFullDistance(float distance)
    {
        return Mathf.Max(0f, (1f / (Mathf.Pow((1f + distance * density), 1)) - depthcutout));
    }
    Color[] GetAdjustedNormals(Color[] normals, int isNegative)
    {
        Color[] newColorArray = new Color[normals.Length];
        normals.CopyTo(newColorArray, 0);

        for (int i = 0; i < newColorArray.Length; i++)
		{
			 if(isNegative > 0)
             {
                 newColorArray[i].r = 1f - newColorArray[i].r;
                 newColorArray[i].g = 1f - newColorArray[i].g;
                 newColorArray[i].b = 1f - newColorArray[i].b;
             }
            newColorArray[i].r = Mathf.Max(0f, newColorArray[i].r - 0.5f) * 2f;
            newColorArray[i].g = Mathf.Max(0f, newColorArray[i].g - 0.5f) * 2f;
            newColorArray[i].b = Mathf.Max(0f, newColorArray[i].b - 0.5f) * 2f;
		}
        return newColorArray;
    }
    Color GetAdjustedNormal(Color color, int isNegative)
    {
        Color v4 = new Color(color.r, color.g, color.b, color.a);
        if (isNegative > 0)
        {
            v4.r = 1f - v4.r;
            v4.g = 1f - v4.g;
            v4.b = 1f - v4.b;
        }
        v4.r = Mathf.Max(0f, v4.r - 0.5f) * 2f;
        v4.g = Mathf.Max(0f, v4.g - 0.5f) * 2f;
        v4.b = Mathf.Max(0f, v4.b - 0.5f) * 2f;

        return v4;
    }

    bool CheckBakeObjectSpaceTextures() {
        if ((objectSpacePosition == null || objectSpaceNormal == null) && bakeObjSpcTextures)
        {
            return true;
        }
        else if (bakeObjSpcTextures && forceBakeIfExists)
        {
            return true;
        }
        else if(objectSpacePosition.width != textureResolution || objectSpaceNormal.width != textureResolution)
        {
            return true;
        }
        return false;
    }

    void SaveTextures(string goName, Texture2D tex2DPositive, Texture2D tex2DNegative)
    {
        System.IO.Directory.CreateDirectory(Application.dataPath + "/Textures/Baked/");
        File.WriteAllBytes(Application.dataPath + "/Textures/Baked/" + goName + "_TrnslPosFinal.png", tex2DPositive.EncodeToPNG());
        File.WriteAllBytes(Application.dataPath + "/Textures/Baked/" + goName + "_TrnslNegFinal.png", tex2DNegative.EncodeToPNG());
        AssetDatabase.Refresh();
    }
}
