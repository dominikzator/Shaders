﻿Shader "Unlit/VF Challenge 1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc" 
            #include "UnityLightingCommon.cginc" 

			struct appdata {
			    float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
			    //float3 normal : NORMAL;
			};

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR0; 
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)    //vertices in world space, runs on every vertex
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //o.uv = v.texcoord;
				o.color.r = o.uv.x;

                
                //o.vertex = float4(o.uv.x,o.uv.y,1,1);
                //o.color.r *= o.uv.x;
                //o.color *= float4(o.uv.x, o.uv.y, 0, 1);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                //col = float4(i.uv.x, i.uv.y, 1, 1);
                return col * i.color;
            }
            ENDCG
        }
    }
}