shader_type canvas_item;

uniform vec2 screen_start;
uniform vec2 screen_size;
uniform vec2 tilemap_start;
uniform vec2 mask_size;
uniform sampler2D mask_texture;

void fragment() {
	vec2 tm_top_left = tilemap_start / mask_size;
	vec2 scale = screen_size / mask_size;
	//vec2 scale = vec2(1.0, 1.0);
	vec2 tilemap_uv = (SCREEN_UV * scale) - tm_top_left;
	//COLOR = vec4(tilemap_uv.x, tilemap_uv.y, 0.0, 1);
	if (texture(mask_texture, tilemap_uv).r < 0.5) {
		COLOR = texture(TEXTURE, UV);
	} else {
		discard;
	}
	//COLOR = texture(mask_texture, tilemap_uv);
	//COLOR = texture(TEXTURE, UV);
}
