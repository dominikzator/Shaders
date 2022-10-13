Shader "Holistic/Cutoff Practise" {
    Properties {
        _FirstColor ("First Color", Color) = (0,0.5,0.5,0.0)
        _SecondColor ("Second Color", Color) = (0,0.5,0.5,0.0)
        _ThirdColor ("Third Color", Color) = (0,0.5,0.5,0.0)
        _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      
      struct Input {
          float3 viewDir;
          float3 worldPos;
      };

      float4 _FirstColor;
      float4 _SecondColor;
      float4 _ThirdColor;
      float _RimPower;
      float _StripeFactor;

      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
          o.Emission = rim > 0.5 ? _FirstColor: rim > 0.3 ? _SecondColor: _ThirdColor;
          //o.Emission = IN.worldPos.y > 1 ? float3(0,1,0): float3(1,0,0);
          //o.Emission = frac(IN.worldPos.y * 10 * _StripeFactor) > 0.4 ? float3(0,1,0) * rim : float3(1,0,0) * rim;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }