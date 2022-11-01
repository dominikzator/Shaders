Shader "Unlit/SineGradientShader"
{
    Properties
    {
        _topColor("Top Color", Color) = (1,1,1,1)
        _bottomColor("Bottom Color", Color) = (1,1,1,1)
         _sineMultiplier ("Sine Multiplier", Range(1,20)) = 1
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

            struct appdata
            {
                float4 vertex : POSITION;
                float4 tex : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _topColor;
            float4 _bottomColor;
            float _sineMultiplier;

            v2f vert (appdata v)    //vertices in world space, runs on every vertex
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float yPercentage = v.vertex.y / 1.2;
                //o.color = lerp(_bottomColor, _topColor, yPercentage);
                float sinValue = clamp(sin(v.vertex.x*_sineMultiplier),0,1);
                //float sinValue = sin(v.vertex.x);
                o.color = sinValue > 0 ? _topColor : _bottomColor;
                o.color = lerp(_bottomColor, _topColor, sinValue);
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target     //vertices in clipping space, runs on every pixel
            {
                return i.color;
            }
            ENDCG
        }
    }
}
