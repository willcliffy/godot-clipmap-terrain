shader_type spatial;

uniform float height_scale;
uniform float texture_size = 512.0;

uniform sampler2D heightmap;
uniform sampler2D normalmap;

varying vec2 tex_position;

void vertex() {
	tex_position = VERTEX.xz / 2.0 + 0.5;
	float vertex_height = texture(heightmap, UV).r;
	VERTEX.y += vertex_height * height_scale;

	float d = 0.001; // delta for derivative approximation

	// Compute the height in nearby points in the x and z directions
	float hL = texture(heightmap, vec2(UV.x - d, UV.y)).r;
	float hR = texture(heightmap, vec2(UV.x + d, UV.y)).r;
	float hD = texture(heightmap, vec2(UV.x, UV.y - d)).r;
	float hU = texture(heightmap, vec2(UV.x, UV.y + d)).r;

	// Compute the derivatives of the height
	float dx = (hR - hL) * height_scale;
	float dz = (hU - hD) * height_scale;

 	// Construct the normal. Note that we flip the dz value because textures 
	// have y going down, while in 3D y goes up
	NORMAL = normalize(vec3(dx, 1.0, -dz));
}
