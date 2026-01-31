shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
varying vec2 global_coords;

void vertex() {
	global_coords = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xy;
}

void fragment() {
	vec4 original_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	float grayness = (original_color.x + original_color.y + original_color.z) / 3.0;
	vec4 grayscale = vec4(grayness, grayness, grayness, original_color.a);
	
	vec2 viewzone = vec2(160, 90);
	
	if (distance(global_coords, viewzone) < 30.0) {
		COLOR = original_color;
	} else {
		COLOR = grayscale;
	}
}
