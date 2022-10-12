Shader "Holistic/Dot Product" 
{
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            half dotp = dot(IN.viewDir, o.Normal);
            half dotpReverse = 1-dot(IN.viewDir, o.Normal);
            //o.Albedo = float3(dotp,1,dotpReverse);
            o.Albedo.r = dotpReverse;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }