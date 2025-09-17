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

    float vmax = max(r, max(g, b));
    float vmin = min(r, min(g, b));

    float h = 0.0;
    float s = 0.0;
    float l = (vmax + vmin) / 2.0;

    if (vmin != vmax) {
        if (l <= 0.5) {
            s = (vmax - vmin) / (vmax + vmin);
        } else {
            s = (vmax - vmin) / (2.0 - vmax - vmin);
        }

        if (vmax == r) {
            h = (g - b) / (vmax - vmin);
        } else if (vmax == g) {
            h = 2.0 + (b - r) / (vmax - vmin);
        } else {
            h = 4.0 + (r - g) / (vmax - vmin);
        }

        h = h * 60.0;
        h = mod(h, 360.0);
    }

    l = 1.0 - l;

    if (s == 0.0) {
        r = l;
        g = l;
        b = l;
    } else {
        float temp1 = 0.0;
        float temp2 = 0.0;
        float tempR = 0.0;
        float tempG = 0.0;
        float tempB = 0.0;

        if (l < 0.5) {
            temp1 = l * (1.0 + s);
        } else {
            temp1 = l + s - l * s;
        }

        temp2 = 2.0 * l - temp1;

        h = mod(h, 360.0);
        h = h / 360.0;

        tempR = mod((h + 1.0 / 3.0), 1.0);
        tempG = h;
        tempB = mod((h - 1.0 / 3.0), 1.0);

        if (6.0 * tempR < 1.0) {
            r = temp2 + (temp1 - temp2) * tempR * 6.0;
        } else if (2.0 * tempR < 1.0) {
            r = temp1;
        } else if (3.0 * tempR < 2.0) {
            r = temp2 + (temp1 - temp2) * (2.0 / 3.0 - tempR) * 6.0;
        } else {
            r = temp2;
        }

        if (6.0 * tempG < 1.0) {
            g = temp2 + (temp1 - temp2) * tempG * 6.0;
        } else if (2.0 * tempG < 1.0) {
            g = temp1;
        } else if (3.0 * tempG < 2.0) {
            g = temp2 + (temp1 - temp2) * (2.0 / 3.0 - tempG) * 6.0;
        } else {
            g = temp2;
        }

        if (6.0 * tempB < 1.0) {
            b = temp2 + (temp1 - temp2) * tempB * 6.0;
        } else if (2.0 * tempB < 1.0) {
            b = temp1;
        } else if (3.0 * tempB < 2.0) {
            b = temp2 + (temp1 - temp2) * (2.0 / 3.0 - tempB) * 6.0;
        } else {
            b = temp2;
        }
    }

    fragColor = vec4(r, g, b, pixColor.a);
}

// vim: ft=glsl
