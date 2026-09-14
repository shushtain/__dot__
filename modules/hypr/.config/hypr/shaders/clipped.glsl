#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    float lum = dot(color, vec3(0.2127, 0.7152, 0.0722));

    const float LUM_MAX = 0.9;
    const float COMPRESSION_START = 0.8;

    float blend = smoothstep(COMPRESSION_START, 1.0, lum);
    float lum_new = mix(lum, LUM_MAX, blend);

    if (lum > 0.0) {
        color *= lum_new / lum;
    }

    fragColor = vec4(color, pixColor.a);
}

// vim: ft=glsl
