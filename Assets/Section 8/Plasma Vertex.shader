Shader "Holistic/Plasma Vertex" {
    Properties {
      _Tint("Colour Tint", Color) = (1,1,1,1)
      _Speed("Speed", Range(1,100)) = 10
      _Scale1("Scale 1", Range(0.1,10)) = 2
      _Scale2("Scale 2", Range(0.1,10)) = 2
      _Scale3("Scale 3", Range(0.1,10)) = 2
      _Scale4("Scale 4", Range(0.1,10)) = 2
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert vertex:vert 
      
      struct Input {
          float2 uv_MainTex;
          float3 vertColor;
      };
      
      float4 _Tint;
      float _Speed;
      float _Scale1;
      float _Scale2;
      float _Scale3;
      float _Scale4;

      struct appdata {
          float4 vertex: POSITION;
          float3 normal: NORMAL;
          float4 texcoord: TEXCOORD0;
          float4 texcoord1: TEXCOORD1;
          float4 texcoord2: TEXCOORD2;
      };
      
      void vert (inout appdata v, out Input o) {
          UNITY_INITIALIZE_OUTPUT(Input,o);

          const float PI = 3.14159265;
          float t = _Time.x * _Speed;
          
          //vertical
          float c = sin(v.vertex.x * _Scale1 + t);

          //horizontal
          c += sin(v.vertex.z * _Scale2 + t);

          //diagonal
          c += sin(_Scale3*(v.vertex.x*sin(t/2.0) + v.vertex.z*cos(t/3))+t);

          //circular
          float c1 = pow(v.vertex.x + 0.5 * sin(t/5),2);
          float c2 = pow(v.vertex.z + 0.5 * cos(t/3),2);
          c += sin(sqrt(_Scale4*(c1 + c2)+1+t));

          float r = sin(c/4.0*PI);
          float g = sin(c/4.0*PI + 2*PI/4);
          float b = sin(c/4.0*PI + 4*PI/4);
          
          o.vertColor = float3(r,g,b);
      }

      void surf (Input IN, inout SurfaceOutput o) {
          //float4 c = tex2D(_MainTex, IN.uv_MainTex);
          o.Albedo = IN.vertColor.rgb;
      }
      ENDCG

    } 
    Fallback "Diffuse"
  }