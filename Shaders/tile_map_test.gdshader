shader_type canvas_item;

uniform vec2 screen_start;
uniform vec2 screen_size;
uniform vec2 tilemap_start;
uniform vec2 tilemap_size;

void fragment() {
	//-25,-25 & 100,100
	//0,0 & 150,150
	vec2 size_ratio = screen_size / tilemap_size;
	//vec2 screen_end = screen_start + screen_size;
	//vec2 tilemap_end = tilemap_start + tilemap_size;
	vec2 tilemap_start_screen = (tilemap_start - screen_start) / screen_size;
	//vec2 tilemap_end_screen = (tilemap_end - screen_end) * size_ratio;
	vec2 tilemap_uv = (SCREEN_UV - tilemap_start_screen) * size_ratio;
	COLOR = vec4(tilemap_uv.x, tilemap_uv.y, 0.5, 1);
}
