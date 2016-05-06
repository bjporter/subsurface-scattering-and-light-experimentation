// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:True,rprd:True,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:33835,y:33926,varname:node_2865,prsc:2|diff-987-OUT,spec-358-OUT,gloss-1813-OUT,normal-824-RGB,emission-1763-OUT;n:type:ShaderForge.SFN_Multiply,id:6343,x:32393,y:33596,varname:node_6343,prsc:2|A-7736-R,B-6665-RGB;n:type:ShaderForge.SFN_Color,id:6665,x:32200,y:33689,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32200,y:33504,ptovrint:True,ptlb:Albedo,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:358,x:31295,y:33644,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:31295,y:33730,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:_Metallic_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_Tex2d,id:1214,x:30330,y:34090,ptovrint:False,ptlb:WorldPosOffset,ptin:_WorldPosOffset,varname:_WorldNormals_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_LightVector,id:2540,x:31162,y:34220,varname:node_2540,prsc:2;n:type:ShaderForge.SFN_Append,id:3553,x:30649,y:34107,varname:node_3553,prsc:2|A-1214-R,B-1214-G,C-1214-B;n:type:ShaderForge.SFN_Dot,id:6304,x:31429,y:34356,varname:node_6304,prsc:2,dt:1|A-2540-OUT,B-5120-XYZ;n:type:ShaderForge.SFN_Multiply,id:4525,x:31590,y:34356,varname:node_4525,prsc:2|A-2552-R,B-6304-OUT;n:type:ShaderForge.SFN_Dot,id:3751,x:31429,y:34544,varname:node_3751,prsc:2,dt:1|A-2540-OUT,B-1677-XYZ;n:type:ShaderForge.SFN_Dot,id:2116,x:31429,y:34714,varname:node_2116,prsc:2,dt:1|A-2540-OUT,B-705-XYZ;n:type:ShaderForge.SFN_Multiply,id:2611,x:31590,y:34544,varname:node_2611,prsc:2|A-2552-G,B-3751-OUT;n:type:ShaderForge.SFN_Multiply,id:3491,x:31590,y:34714,varname:node_3491,prsc:2|A-2552-B,B-2116-OUT;n:type:ShaderForge.SFN_Add,id:6991,x:31933,y:34352,varname:node_6991,prsc:2|A-4525-OUT,B-2611-OUT,C-3491-OUT,D-33-OUT;n:type:ShaderForge.SFN_Divide,id:5609,x:32102,y:34352,varname:node_5609,prsc:2|A-6991-OUT,B-3257-OUT;n:type:ShaderForge.SFN_Vector1,id:3257,x:31933,y:34485,varname:node_3257,prsc:2,v1:3;n:type:ShaderForge.SFN_ComponentMask,id:2552,x:30803,y:34107,varname:node_2552,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-3553-OUT;n:type:ShaderForge.SFN_Transform,id:5120,x:31259,y:34356,varname:node_5120,prsc:2,tffrom:1,tfto:0|IN-7196-OUT;n:type:ShaderForge.SFN_Transform,id:1677,x:31259,y:34527,varname:node_1677,prsc:2,tffrom:1,tfto:0|IN-1840-OUT;n:type:ShaderForge.SFN_Transform,id:705,x:31259,y:34713,varname:node_705,prsc:2,tffrom:1,tfto:0|IN-7282-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:8418,x:31162,y:33820,varname:node_8418,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1763,x:32289,y:34330,varname:node_1763,prsc:2|A-9494-RGB,B-5609-OUT,C-3998-OUT,D-8621-RGB;n:type:ShaderForge.SFN_LightColor,id:9494,x:32085,y:34485,varname:node_9494,prsc:2;n:type:ShaderForge.SFN_Vector1,id:6796,x:30971,y:33960,varname:node_6796,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Slider,id:3998,x:31947,y:34626,ptovrint:False,ptlb:TranslucencyIntensity,ptin:_TranslucencyIntensity,varname:node_3998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.95,max:1;n:type:ShaderForge.SFN_OneMinus,id:5057,x:32090,y:34135,varname:node_5057,prsc:2|IN-3998-OUT;n:type:ShaderForge.SFN_Multiply,id:1709,x:32443,y:34304,varname:node_1709,prsc:2|A-8418-OUT,B-1763-OUT;n:type:ShaderForge.SFN_Vector3,id:7196,x:30958,y:34357,varname:node_7196,prsc:2,v1:1,v2:0,v3:0;n:type:ShaderForge.SFN_Vector3,id:1840,x:31094,y:34527,varname:node_1840,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Vector3,id:7282,x:31094,y:34713,varname:node_7282,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Color,id:8621,x:32077,y:34718,ptovrint:False,ptlb:TranslucencyColor,ptin:_TranslucencyColor,varname:node_8621,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:987,x:32555,y:33847,varname:node_987,prsc:2|A-6343-OUT,B-5057-OUT;n:type:ShaderForge.SFN_Tex2d,id:824,x:32873,y:34004,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_824,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Dot,id:814,x:31415,y:34956,varname:node_814,prsc:2,dt:1|A-2540-OUT,B-1970-XYZ;n:type:ShaderForge.SFN_Dot,id:9133,x:31415,y:35144,varname:node_9133,prsc:2,dt:1|A-2540-OUT,B-8737-XYZ;n:type:ShaderForge.SFN_Dot,id:7644,x:31415,y:35314,varname:node_7644,prsc:2,dt:1|A-2540-OUT,B-3875-XYZ;n:type:ShaderForge.SFN_Transform,id:1970,x:31245,y:34956,varname:node_1970,prsc:2,tffrom:1,tfto:0|IN-6728-OUT;n:type:ShaderForge.SFN_Transform,id:8737,x:31245,y:35127,varname:node_8737,prsc:2,tffrom:1,tfto:0|IN-5574-OUT;n:type:ShaderForge.SFN_Transform,id:3875,x:31245,y:35313,varname:node_3875,prsc:2,tffrom:1,tfto:0|IN-243-OUT;n:type:ShaderForge.SFN_Vector3,id:6728,x:31080,y:34956,varname:node_6728,prsc:2,v1:-1,v2:0,v3:0;n:type:ShaderForge.SFN_Vector3,id:5574,x:31080,y:35127,varname:node_5574,prsc:2,v1:0,v2:-1,v3:0;n:type:ShaderForge.SFN_Vector3,id:243,x:31080,y:35313,varname:node_243,prsc:2,v1:0,v2:0,v3:-1;n:type:ShaderForge.SFN_Multiply,id:5928,x:31602,y:34956,varname:node_5928,prsc:2|A-4689-R,B-814-OUT;n:type:ShaderForge.SFN_Multiply,id:6234,x:31602,y:35144,varname:node_6234,prsc:2|A-4689-G,B-9133-OUT;n:type:ShaderForge.SFN_Multiply,id:6475,x:31602,y:35314,varname:node_6475,prsc:2|A-4689-B,B-7644-OUT;n:type:ShaderForge.SFN_Tex2d,id:5744,x:30330,y:34274,ptovrint:False,ptlb:WorldNegPosOffset,ptin:_WorldNegPosOffset,varname:_WorldPosOffset_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Append,id:3116,x:30649,y:34291,varname:node_3116,prsc:2|A-5744-R,B-5744-G,C-5744-B;n:type:ShaderForge.SFN_ComponentMask,id:4689,x:30816,y:34291,varname:node_4689,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-3116-OUT;n:type:ShaderForge.SFN_Add,id:33,x:31926,y:34963,varname:node_33,prsc:2|A-5928-OUT,B-6234-OUT,C-6475-OUT;n:type:ShaderForge.SFN_Add,id:7664,x:31119,y:34357,varname:node_7664,prsc:2|A-2659-OUT,B-7196-OUT;n:type:ShaderForge.SFN_Append,id:1663,x:30992,y:34191,varname:node_1663,prsc:2|A-2552-R,B-333-OUT,C-333-OUT;n:type:ShaderForge.SFN_Vector1,id:333,x:30739,y:34512,varname:node_333,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:2659,x:30940,y:34448,varname:node_2659,prsc:2|A-1663-OUT,B-6796-OUT;proporder:6665-7736-824-358-1813-1214-5744-8621-3998;pass:END;sub:END;*/

Shader "FPires/Translucency - Basic" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo", 2D) = "white" {}
        _Normal ("Normal", 2D) = "bump" {}
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0.8
        _WorldPosOffset ("WorldPosOffset", 2D) = "white" {}
        _WorldNegPosOffset ("WorldNegPosOffset", 2D) = "white" {}
        _TranslucencyColor ("TranslucencyColor", Color) = (1,1,1,1)
        _TranslucencyIntensity ("TranslucencyIntensity", Range(0, 1)) = 0.95
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _WorldPosOffset; uniform float4 _WorldPosOffset_ST;
            uniform float _TranslucencyIntensity;
            uniform float4 _TranslucencyColor;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _WorldNegPosOffset; uniform float4 _WorldNegPosOffset_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(_Object2World, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                d.boxMax[0] = unity_SpecCube0_BoxMax;
                d.boxMin[0] = unity_SpecCube0_BoxMin;
                d.probePosition[0] = unity_SpecCube0_ProbePosition;
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.boxMax[1] = unity_SpecCube1_BoxMax;
                d.boxMin[1] = unity_SpecCube1_BoxMin;
                d.probePosition[1] = unity_SpecCube1_ProbePosition;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = ((_MainTex_var.r*_Color.rgb)*(1.0 - _TranslucencyIntensity)); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _Metallic, specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4) );
                float3 directSpecular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _WorldPosOffset_var = tex2D(_WorldPosOffset,TRANSFORM_TEX(i.uv0, _WorldPosOffset));
                float3 node_2552 = float3(_WorldPosOffset_var.r,_WorldPosOffset_var.g,_WorldPosOffset_var.b).rgb;
                float3 node_7196 = float3(1,0,0);
                float4 _WorldNegPosOffset_var = tex2D(_WorldNegPosOffset,TRANSFORM_TEX(i.uv0, _WorldNegPosOffset));
                float3 node_4689 = float3(_WorldNegPosOffset_var.r,_WorldNegPosOffset_var.g,_WorldNegPosOffset_var.b).rgb;
                float3 node_1763 = (_LightColor0.rgb*(((node_2552.r*max(0,dot(lightDirection,mul( _Object2World, float4(node_7196,0) ).xyz.rgb)))+(node_2552.g*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,1,0),0) ).xyz.rgb)))+(node_2552.b*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,0,1),0) ).xyz.rgb)))+((node_4689.r*max(0,dot(lightDirection,mul( _Object2World, float4(float3(-1,0,0),0) ).xyz.rgb)))+(node_4689.g*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,-1,0),0) ).xyz.rgb)))+(node_4689.b*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,0,-1),0) ).xyz.rgb)))))/3.0)*_TranslucencyIntensity*_TranslucencyColor.rgb);
                float3 emissive = node_1763;
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _WorldPosOffset; uniform float4 _WorldPosOffset_ST;
            uniform float _TranslucencyIntensity;
            uniform float4 _TranslucencyColor;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _WorldNegPosOffset; uniform float4 _WorldNegPosOffset_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(_Object2World, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = ((_MainTex_var.r*_Color.rgb)*(1.0 - _TranslucencyIntensity)); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _Metallic, specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4) );
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _WorldPosOffset; uniform float4 _WorldPosOffset_ST;
            uniform float _TranslucencyIntensity;
            uniform float4 _TranslucencyColor;
            uniform sampler2D _WorldNegPosOffset; uniform float4 _WorldNegPosOffset_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(_Object2World, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _WorldPosOffset_var = tex2D(_WorldPosOffset,TRANSFORM_TEX(i.uv0, _WorldPosOffset));
                float3 node_2552 = float3(_WorldPosOffset_var.r,_WorldPosOffset_var.g,_WorldPosOffset_var.b).rgb;
                float3 node_7196 = float3(1,0,0);
                float4 _WorldNegPosOffset_var = tex2D(_WorldNegPosOffset,TRANSFORM_TEX(i.uv0, _WorldNegPosOffset));
                float3 node_4689 = float3(_WorldNegPosOffset_var.r,_WorldNegPosOffset_var.g,_WorldNegPosOffset_var.b).rgb;
                float3 node_1763 = (_LightColor0.rgb*(((node_2552.r*max(0,dot(lightDirection,mul( _Object2World, float4(node_7196,0) ).xyz.rgb)))+(node_2552.g*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,1,0),0) ).xyz.rgb)))+(node_2552.b*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,0,1),0) ).xyz.rgb)))+((node_4689.r*max(0,dot(lightDirection,mul( _Object2World, float4(float3(-1,0,0),0) ).xyz.rgb)))+(node_4689.g*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,-1,0),0) ).xyz.rgb)))+(node_4689.b*max(0,dot(lightDirection,mul( _Object2World, float4(float3(0,0,-1),0) ).xyz.rgb)))))/3.0)*_TranslucencyIntensity*_TranslucencyColor.rgb);
                o.Emission = node_1763;
                
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffColor = ((_MainTex_var.r*_Color.rgb)*(1.0 - _TranslucencyIntensity));
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, _Metallic, specColor, specularMonochrome );
                float roughness = 1.0 - _Gloss;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
