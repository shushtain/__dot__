#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float gray = dot(pixColor.rgb, vec3(0.212656, 0.715158, 0.072186));
    fragColor = vec4(vec3(gray), pixColor.a);
}

// vim: ft=glsl
