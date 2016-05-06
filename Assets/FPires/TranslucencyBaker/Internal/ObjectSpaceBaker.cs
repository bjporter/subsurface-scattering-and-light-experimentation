using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

//Object Space Baker
//v1.0
//Fernando Pires

public struct BakedTextures
{
    public Texture2D tex2DObjectPos;
    public Texture2D tex2DObjectNormal;

    public BakedTextures(Texture2D tex2DObjectPos, Texture2D tex2DObjectNormal)
    {
        this.tex2DObjectPos = tex2DObjectPos;
        this.tex2DObjectNormal = tex2DObjectNormal;
    }
}
public class ObjectSpaceBaker {

    public Texture2D tex2DObjectPos;
    public Texture2D tex2DObjectNormal;

    //public bool normalizeAxes = false;
	
	public BakedTextures GenerateTextures (GameObject go, int res, int multisample, int spread, bool saveTextures) {
        //res = The resolution of the texture. Min of 32.
        //multisample = How many square samples per texture pixel. 1 = (1*1), 2 = (2*2), etc. Min of 1.
        //spread = Spreads the content of filled pixels to adjacent unfilled pixels in the baked maps. 
        // This is used to avoid texture artifacts from bilinear filters, etc. Each value convolutes the image an additional time. Min of 0.

        #region SaveGoTransform
        Vector3 saveRotation = go.transform.localEulerAngles;
        Vector3 saveScale = go.transform.localScale;
        Transform saveParent = go.transform.parent;

        go.transform.parent = null;
        go.transform.localEulerAngles = new Vector3(0f, 0f, 0f);

        Vector3 boundarySize = go.GetComponent<Renderer>().bounds.size;
        go.transform.localScale = new Vector3(1f, 1f, 1f);
        Vector3 boundarySizeOld = go.GetComponent<Renderer>().bounds.size;
        float maxSize = Mathf.Max(boundarySize.x, boundarySize.y, boundarySize.z);
        #endregion

        #region Initialize
        if (res < 32) { res = 32; }
        if (multisample < 1) { multisample = 1; }
        if (spread < 0) { spread = 0; }

        tex2DObjectPos = new Texture2D(res, res, TextureFormat.ARGB32, false, false);
        tex2DObjectNormal = new Texture2D(res, res, TextureFormat.ARGB32, false, false);

        Mesh mesh = go.GetComponent<MeshFilter>().sharedMesh;
        string goName = go.name;
        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;
        Vector2[] uvs = mesh.uv;
        int[] triangles = mesh.triangles;
        #endregion

        #region BakeTextures
        for (int x = 0; x < res; x++)
        {
            for (int y = 0; y < res; y++)
            {
                List<Vector3> vectorArrayPos = new List<Vector3>(multisample);
                List<Vector3> vectorArrayNormal = new List<Vector3>(multisample);

                for (int m = 0; m < multisample; m++)
                {
                    float size = res * multisample;
                    float doubleSize = 1f/(size * 2f); //Offsets half a pixel to the right.
                    Vector2 p = new Vector2((float)(x*multisample + m) / size + doubleSize , (float)(y*multisample+m) / size + doubleSize);
                    for (int i = 0; i < triangles.Length; i+=3)
                    {
                        Vector2 uvA = uvs[triangles[i]];
                        Vector2 uvB = uvs[triangles[i+1]];
                        Vector2 uvC = uvs[triangles[i+2]];

                        Vector3 barycentric = GetBarycentric(uvA, uvB, uvC, p);
                        if (InTriangle(barycentric))
                        {
                            //Interpolates between the triangle coords in Object Space using the UV barycentric.
                            Vector3 interpolatedPos = new Vector3(vertices[triangles[i]].x * barycentric.x +
                                                            vertices[triangles[i + 1]].x * barycentric.y +
                                                            vertices[triangles[i + 2]].x * barycentric.z + 0.5f,
                                                            vertices[triangles[i]].y * barycentric.x +
                                                            vertices[triangles[i + 1]].y * barycentric.y +
                                                            vertices[triangles[i + 2]].y * barycentric.z + 0.5f,
                                                            vertices[triangles[i]].z * barycentric.x +
                                                            vertices[triangles[i + 1]].z * barycentric.y +
                                                            vertices[triangles[i + 2]].z * barycentric.z + 0.5f);
                            Vector3 interpolatedNormal = new Vector3(normals[triangles[i]].x * barycentric.x +
                                                            normals[triangles[i + 1]].x * barycentric.y +
                                                            normals[triangles[i + 2]].x * barycentric.z + 0.5f,
                                                            normals[triangles[i]].y * barycentric.x +
                                                            normals[triangles[i + 1]].y * barycentric.y +
                                                            normals[triangles[i + 2]].y * barycentric.z + 0.5f,
                                                            normals[triangles[i]].z * barycentric.x +
                                                            normals[triangles[i + 1]].z * barycentric.y +
                                                            normals[triangles[i + 2]].z * barycentric.z + 0.5f);

                            vectorArrayPos.Add(interpolatedPos);
                            vectorArrayNormal.Add(interpolatedNormal);
                            break;
                        }
                    }    
                }
                Vector3 finalVec = new Vector3(0f, 0f, 0f);
                if (vectorArrayPos.Count > 0)
                {
                    foreach (Vector3 v in vectorArrayPos)
                    {
                        finalVec += v;
                    }
                    finalVec = finalVec / vectorArrayPos.Count;

                    Color color = new Color(finalVec.x, finalVec.y, finalVec.z, 1f);
                    tex2DObjectPos.SetPixel(x, y, color);
                }
                finalVec = new Vector3(0f, 0f, 0f);
                if (vectorArrayNormal.Count > 0)
                {
                    foreach (Vector3 v in vectorArrayNormal)
                    {
                        finalVec += v;
                    }
                    finalVec = finalVec / vectorArrayNormal.Count;

                    Color color = new Color(finalVec.x, finalVec.y, finalVec.z, 1f);
                    tex2DObjectNormal.SetPixel(x, y, color);
                }
            }
        }
        #endregion
        #region FinalizeTextures
        tex2DObjectPos.Apply();
        tex2DObjectNormal.Apply();
        SpreadFilledPixels(tex2DObjectPos,spread);
        SpreadFilledPixels(tex2DObjectNormal, spread);
        #endregion

        #region ResetGoTransform
        go.transform.parent = saveParent;
        go.transform.localScale = saveScale;
        go.transform.localEulerAngles = saveRotation;
        #endregion

        if (saveTextures)
        {
            SaveTextures(goName, tex2DObjectPos, tex2DObjectNormal);
        }
        return new BakedTextures(tex2DObjectPos, tex2DObjectNormal);
	}

    void SaveTextures(string goName, Texture2D tex2DPos, Texture2D tex2DNormal)
    {
        System.IO.Directory.CreateDirectory(Application.dataPath + "/Textures/Baked/");
        File.WriteAllBytes(Application.dataPath + "/Textures/Baked/" + goName + "_ObjSpcPos.png", tex2DPos.EncodeToPNG());
        File.WriteAllBytes(Application.dataPath + "/Textures/Baked/" + goName + "_ObjSpcNrm.png", tex2DNormal.EncodeToPNG());
        AssetDatabase.Refresh();
    }

    void SpreadFilledPixels(Texture2D tex2D, int iterations)
    {
        for (int i = 0; i < iterations; i++)
        {
        Color32[] colors = tex2D.GetPixels32();
        for (int x = 0; x < tex2D.width; x++)
        {
            for (int y = 0; y < tex2D.height; y++)
            {
                if (colors[x + y * tex2D.width].a < 128)
                {
                    bool keepLooping = true;
                    for (int xx = -1; xx < 2; xx++)
                    {
                        if (!keepLooping) { break; }
                        for (int yy = -1; yy < 2; yy++)
                        {
                            if (xx != 0 || yy != 0)
                            {
                                int sumX = x + xx;
                                int sumY = y + yy;
                                if (sumX > 0 && sumX < tex2D.width && sumY > 0 && sumY < tex2D.height)
                                {
                                    int colorIndex = sumX + sumY * tex2D.width;
                                    if (colors[colorIndex].a >= 128)
                                    {
                                        //We set the alpha to half to distinguish pixels that are inside the triangle when
                                        //calculating the Translucency Map.
                                        Color32 color = new Color32(colors[colorIndex].r, colors[colorIndex].g, colors[colorIndex].b, 128);
                                        tex2D.SetPixel(x, y, color);
                                        keepLooping = false;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        tex2D.Apply();    
        }
    }

    Vector3 GetBarycentric(Vector2 v1, Vector2 v2, Vector2 v3, Vector2 p)
    {
        //Credits to Bunny83
        Vector3 B = new Vector3();
        B.x = ((v2.y - v3.y) * (p.x - v3.x) + (v3.x - v2.x) * (p.y - v3.y)) /
            ((v2.y - v3.y) * (v1.x - v3.x) + (v3.x - v2.x) * (v1.y - v3.y));
        B.y = ((v3.y - v1.y) * (p.x - v3.x) + (v1.x - v3.x) * (p.y - v3.y)) /
            ((v3.y - v1.y) * (v2.x - v3.x) + (v1.x - v3.x) * (v2.y - v3.y));
        B.z = 1 - B.x - B.y;
        return B;
    }
    bool InTriangle(Vector3 barycentric)
    {
        //Credits to Bunny83
        return (barycentric.x >= 0.0f) && (barycentric.x <= 1.0f)
            && (barycentric.y >= 0.0f) && (barycentric.y <= 1.0f)
            && (barycentric.z >= 0.0f); //(barycentric.z <= 1.0f)
    }
}
