#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float rn = pixColor.r;
    float gn = pixColor.g;
    float bn = pixColor.b;

    float PI = 3.14159;
    float A = -0.14861;
    float B = 1.78277;
    float C = -0.29227;
    float D = -0.90649;
    float E = 1.97294;
    float ED = E * D;
    float EB = E * B;
    float BC_DA = B * C - D * A;

    float ln = (BC_DA * bn + ED * rn - EB * gn) / (BC_DA + ED - EB);
    float bl = bn - ln;
    float k = (E * (gn - ln) - C * bl) / D;

    float xn = 0.0;
    if (ln > 0.0 && ln < 1.0) {
        xn = sqrt(k * k + bl * bl) / (E * ln * (1.0 - ln));
    }

    float h = 0.0;
    if (xn > 0.0) {
        h = atan(k, bl) * (180.0 / PI) - 120.0;
    }

    h = mod(h, 360.0);
    xn = min(xn, 0.5);

    if (ln <= 0.0) {
        fragColor = vec4(0.0, 0.0, 0.0, pixColor.a);
    } else if (ln >= 1.0) {
        fragColor = vec4(1.0, 1.0, 1.0, pixColor.a);
    } else {
        if (xn <= 0.0) {
            h = 0.0;
        } else {
            h = PI * (h + 120.0) / 180.0;
        }

        k = xn * ln * (1.0 - ln);
        float cosh = cos(h);
        float sinh = sin(h);

        float r = ln + k * (A * cosh + B * sinh);
        float g = ln + k * (C * cosh + D * sinh);
        float b = ln + k * (E * cosh);

        fragColor = vec4(r, g, b, pixColor.a);
    }
}

// vim: ft=glsl
