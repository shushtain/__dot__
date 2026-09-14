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

    float rg = r - g;
    float rb = r - b;

    vec3 color;
    if (rg > 0.25 && rb > 0.3) {
        color = vec3(r, g, b);
    } else {
        float gray = dot(pixColor.rgb, vec3(0.212656, 0.715158, 0.072186));
        color = vec3(gray);
    }

    fragColor = vec4(color, pixColor.a);
}

// vim: ft=glsl
