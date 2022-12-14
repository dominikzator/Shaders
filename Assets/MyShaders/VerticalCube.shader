﻿Shader "MyShaders/VerticalCube"
{
    Properties
    {
        [HideInInspector] _Scale ("Scale", Range (0.0, 100.0)) = 0.0
        _SphereRadius ("SphereRadius", Range (0.5, 20.0)) = 2.5
        _Alpha ("Alpha", Range (0.0, 1.0)) = 1.0
        
        _Rows ("Rows", int) = 1
        _Columns ("Columns", int) = 1
        _Depth ("Depth", int) = 1
    }
    
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc" 

            struct appdata
            {
                float4 vertex : POSITION;
                //float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float3 wPos : TEXCOORD0;
                //fixed4 diff : COLOR0; 
                float4 pos : SV_POSITION;
            };

            float _Scale;
            float _SphereRadius;
            float _Alpha;
            int _Rows;
            int _Columns;
            int _Depth;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                
                return o;
            }

            #define STEPS 5000
            #define STEP_SIZE 0.01

            bool SphereHit(float3 p, float3 center, float radius)
            {
                return distance(p, center) < radius;
            }

            bool CheckPatternHit(float3 position)
            {
                float3 CubeCenter = float3(unity_ObjectToWorld._m03,unity_ObjectToWorld._m13,unity_ObjectToWorld._m23);

                float offsetA = _Scale / (_Rows + 1);
                float offsetB = _Scale / (_Columns + 1);
                float offsetC = _Scale / (_Depth + 1);
                for (int a = 1; a <= _Rows; a++)
                {
                    float currentPointX = _Scale/2 - offsetA * a;
                    for (int b = 1; b <= _Columns; b++)
                    {
                        float currentPointY = _Scale/2 - offsetB * b;
                        for (int c = 1; c <= _Depth; c++)
                        {
                            float currentPointZ = _Scale/2 - offsetC * c;
                            float3 currentSpherePoint = CubeCenter + float3(currentPointX, currentPointY, currentPointZ);
                            if(SphereHit(position, currentSpherePoint, _SphereRadius))
                            {
                                return position;
                            }
                        }
                    }
                }
                return false;
            }


            float4 RaymarchHit(float3 position, float3 direction)
            {
                for (int i = 0; i < STEPS; i++)
                {
                    if(CheckPatternHit(position))
                    {
                        return float4(lerp(float3(0.5,0.5,0.5), position.xyz, _Alpha), 1);
                    }
                    position += direction * STEP_SIZE;
                }

                return float4(0.5,0.5,0.5,1);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float3 worldPosition = i.wPos;
                float3 viewDirection = normalize(worldPosition - _WorldSpaceCameraPos);
                float4 color = RaymarchHit(worldPosition, viewDirection);
                
                if(length(color) != 0)
                {
                    return color;
                }
                else
                {
                    return fixed4(1,1,1,0);
                }
            }
            ENDCG
        }
    }
}
