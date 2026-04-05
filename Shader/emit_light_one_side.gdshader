shader_type spatial;
render_mode cull_back;

void fragment() {
    // Surface normal in world space
    vec3 normal = NORMAL;

    // Only emit light when facing downward
    float emit_strength = smoothstep(0.0, 0.3, -normal.y);

    ALBEDO = vec3(0.0); // no base color
    EMISSION = vec3(1.0, 0.667, 0.388) * emit_strength * 5.0;
}