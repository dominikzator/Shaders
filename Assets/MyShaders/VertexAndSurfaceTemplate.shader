Shader "MyShaders/VertexAndSurfaceTemplate" {
    Properties {
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert vertex:vert 
      
      struct Input {
          float2 uv_MainTex;
          float3 vertColor;
      };

      struct appdata {
          float4 vertex: POSITION;
          float3 normal: NORMAL;
          float4 texcoord: TEXCOORD0;
          float4 texcoord1: TEXCOORD1;
          float4 texcoord2: TEXCOORD2;
      };

      struct v2f
      {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
      };
      
      void vert (inout appdata v, out Input o) {
          UNITY_INITIALIZE_OUTPUT(Input,o);
          
      }

      fixed4 frag (v2f i) : SV_Target     //vertices in clipping space, runs on every pixel
            {
                fixed4 col = i.color;
                col.r = i.vertex.x/2000;
                col.g = i.vertex.y/2000;
                return col;
            }

      void surf (Input IN, inout SurfaceOutput o) {
          //float4 c = tex2D(_MainTex, IN.uv_MainTex);
          o.Albedo = IN.vertColor.rgb;
      }
      ENDCG

    } 
    Fallback "Diffuse"
  }