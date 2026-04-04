shader_type spatial;

void light() {
    // This will discard the fragment if it is illuminated
    if (LIGHT_COLOR.r * ATTENUATION < 0.5) {
        discard;
    }
}
