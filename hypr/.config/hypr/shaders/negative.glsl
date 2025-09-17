#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float r = 1.0 - pixColor.r;
    float g = 1.0 - pixColor.g;
    float b = 1.0 - pixColor.b;
    fragColor = vec4(r, g, b, pixColor.a);
}

// vim: ft=glsl
