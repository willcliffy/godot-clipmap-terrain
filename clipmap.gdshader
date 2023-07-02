shader_type spatial;

uniform float xz_scale: hint_range(0.0, 0.25) = 0.01;

uniform float height: hint_range(-25.0, 25.0) = 5.0;
uniform vec2 uv = vec2(0, 0);

uniform sampler2D terrain_noise;
uniform sampler2D normal_map;

varying vec2 texture_position;
varying float vertex_height;

void vertex() {
  texture_position = xz_scale * (VERTEX.xz  + uv);
  vertex_height = texture(terrain_noise, texture_position).r;
  VERTEX.y += vertex_height * height;
}

void fragment() {
	ALBEDO = vec3(0.15, 0.11, 0.09);
	NORMAL_MAP = texture(normal_map, texture_position).xyz;
}
