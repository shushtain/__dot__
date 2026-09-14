#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float gray = dot(pixColor.rgb, vec3(0.212656, 0.715158, 0.072186));
    float r = clamp(gray * 1.5, 0.0, 1.0);
    float g_b = pow(gray, 2.0);
    fragColor = vec4(r, g_b, g_b, pixColor.a);
}

// vim: ft=glsl
