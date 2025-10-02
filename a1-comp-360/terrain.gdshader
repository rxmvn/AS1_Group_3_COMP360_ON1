shader_type spatial;

// how tall the terrain can go
uniform float max_height = 64.0;

// texture that controls terrain colors
uniform sampler2D color_map;

// texture that adds fake surface bumps
uniform sampler2D bump_map;

void fragment() {
    // get the world position of this vertex
    vec4 world_pos = INV_VIEW_MATRIX * vec4(VERTEX, 1.0);

    // convert world position back into model space
    vec3 local_pos = (inverse(MODEL_MATRIX) * world_pos).xyz;

    // work out how high this vertex is, scaled by max height
    float height_percent = (local_pos.y / max_height) + 0.5;

    // pick a color from the gradient image based on the height
    ALBEDO = texture(color_map, vec2(height_percent, 0.0)).rgb;

    // add detail bumps from the normal map texture
    NORMAL_MAP = texture(bump_map, UV).xyz;
}
