Shader "Holistic/Cutoff" {
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}

        _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
        _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
        _StripeFactor ("Stripe Factor", Range(0,5.0)) = 3.0
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_myDiffuse;
          float3 viewDir;
          float3 worldPos;
      };

      sampler2D _myDiffuse;
      float4 _RimColor;
      float _RimPower;
      float _StripeFactor;

      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;

          half tex = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
          half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
          //o.Emission = rim > 0.5 ? float3(1,1,1): rim > 0.3 ? float3(1,0,0): 0;
          //o.Emission = IN.worldPos.y > 1 ? float3(0,1,0): float3(1,0,0);
          o.Emission = frac(IN.worldPos.y * 10 * _StripeFactor) > 0.4 ? float3(0,1,0) * rim : float3(1,0,0) * rim;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }