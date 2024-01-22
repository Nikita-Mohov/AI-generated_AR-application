Shader "Custom/NewSurfaceShader1" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "white" { }
        _MaterialColor("Material Color", Color) = (1, 1, 1, 1)
        _AnimationSpeed("Animation Speed", Range(0.1, 10)) = 1
        _Intensity("Intensity", Range(0.1, 5)) = 1
        _GlowColor("Glow Color", Color) = (0, 0, 1, 1)
        _GlowIntensity("Glow Intensity", Range(0, 1)) = 0
        _XAnimation("X Animation", Range(0, 1)) = 1
        _XSpeed("X Speed", Range(0.1, 10)) = 1
        _YAnimation("Y Animation", Range(0, 1)) = 1
        _YSpeed("Y Speed", Range(0.1, 10)) = 1
        _DeformSpeed("Animation DeformSpeed", Range(0, 10)) = 1
        _Deformint("Animation Deformint", Range(0, 1)) = 0.1
        _Transparency("Transparency", Range(0, 1)) = 1
    }

        SubShader{
            Tags { "Queue" = "Overlay" }
            LOD 100

            CGPROGRAM
            #pragma surface surf Lambert vertex:vert alpha:fade

            sampler2D _MainTex;
            fixed4 _MaterialColor;
            float _AnimationSpeed;
            float _Intensity;
            fixed4 _GlowColor;
            float _GlowIntensity;
            float _XAnimation;
            float _XSpeed;
            float _YAnimation;
            float _YSpeed;
            float _DeformSpeed;
            float _Deformint;
            float _Transparency;

            struct Input {
                float2 uv_MainTex;
            };

            void vert(inout appdata_full v, out Input o) {
                float time = _Time.y * _DeformSpeed;
                v.vertex.y += sin(time + v.vertex.x * 10) * _Deformint;
                o.uv_MainTex = UnityObjectToClipPos(v.vertex);
            }

            void surf(Input IN, inout SurfaceOutput o) {
                float time = _Time.y * _AnimationSpeed;

                float xOffset = 0;
                if (_XAnimation > 0) {
                    xOffset = frac(time + IN.uv_MainTex.x * 10) * _Intensity * _XSpeed;
                }

                float yOffset = 0;
                if (_YAnimation > 0) {
                    yOffset = frac(time + IN.uv_MainTex.y * 10) * _Intensity * _YSpeed;
                }

                fixed4 c = tex2D(_MainTex, IN.uv_MainTex + float2(xOffset, yOffset)) * _MaterialColor;

                fixed4 glow = _GlowIntensity * _GlowColor;
                c.rgb += glow.rgb;

                o.Albedo = c.rgb;
                o.Alpha = c.a * _Transparency;
            }
            ENDCG
        }
            Fallback "Diffuse"
}
