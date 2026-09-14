#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float r = pixColor.r;
    float g = pixColor.g;
    float b = pixColor.b;
    fragColor = vec4(r, g, g, pixColor.a);
}

// vim: ft=glsl
