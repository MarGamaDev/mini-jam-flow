shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec2 time_area_coords;
uniform float time_area_radius;
uniform float color_percent;

group_uniforms edge_settings.base_edge;
uniform float base_edge_rotate_speed = 10.0;
uniform float base_edge_frequency = 50.0;
uniform float base_edge_wave_intensity = 0.5;
group_uniforms;

group_uniforms edge_settings.outer_edge;
uniform float outer_edge_rotate_speed = 10.0;
uniform float outer_edge_frequency = 50.0;
uniform float outer_edge_wave_intensity = 0.5;
group_uniforms;

group_uniforms edge_settings.inner_edge;
uniform float inner_edge_rotate_speed = 10.0;
uniform float inner_edge_frequency = 50.0;
uniform float inner_edge_wave_intensity = 0.5;
uniform float inner_edge_min_width = 1.0;
group_uniforms;

varying vec2 global_coords;

void vertex() {
	global_coords = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xy;
}

void fragment() {
	vec4 original_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	float grayness = (original_color.x + original_color.y + original_color.z) / 3.0 * 0.8;
	vec4 grayscale = vec4(grayness, grayness, grayness, original_color.a);
	float distance_to_point = distance(global_coords, time_area_coords);
	vec2 offset_from_center = global_coords - time_area_coords;
	float point_radians = atan(offset_from_center.x, offset_from_center.y);
	
	float base_edge = sin(TIME * base_edge_rotate_speed + point_radians * base_edge_frequency) * base_edge_wave_intensity;
	
	float outer_edge = (sin(TIME * outer_edge_rotate_speed + point_radians * outer_edge_frequency) + 1.0) / 2.0 * outer_edge_wave_intensity;
	float adjusted_radius = time_area_radius + base_edge;
	
	float inner_edge = inner_edge_min_width + (sin(TIME * inner_edge_rotate_speed + point_radians * inner_edge_frequency) + 1.0) / 2.0 * inner_edge_wave_intensity;
	
	if (distance_to_point < adjusted_radius + outer_edge && distance_to_point > adjusted_radius - inner_edge) {
		COLOR = vec4(162.0/255.0, 113.0/255.0, 1, 0.5);
	} else if (distance_to_point < adjusted_radius) {
		COLOR = original_color;
	} else {
		COLOR = grayscale + ((original_color - grayscale) * color_percent);
	}
}
