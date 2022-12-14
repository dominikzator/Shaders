Shader "MyShaders/Colour Hologram"
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

            struct Input {
                float3 viewDir;
            };

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
	      	    float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)    //vertices in world space, runs on every vertex
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.color.r = (v.vertex.x+5)/10;
                //o.color.g = (v.vertex.z+10)/10;
                //o.color = fixed4(1,0,0,1);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target     //vertices in clipping space, runs on every pixel
            {
                fixed4 col = i.color;
                col.r = i.vertex.x/2000;
                col.g = i.vertex.y/2000;
                return col;
            }
            ENDCG
        }
    }
}
