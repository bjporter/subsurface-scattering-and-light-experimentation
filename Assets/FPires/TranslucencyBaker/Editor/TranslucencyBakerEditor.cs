using UnityEngine;
using System.Collections;
using UnityEditor;

[CustomEditor(typeof(TranslucencyBaker))]
public class TranslucencyBakerEditor : Editor {

    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        TranslucencyBaker myScript = (TranslucencyBaker)target;
        if (GUILayout.Button("Generate Texture"))
        {
            myScript.GenerateTranslucencyTexture();
        }
    }
}
