@tool
extends StaticBody3D

const UV_SCALE = 0.01

func _ready():
	var terrain = get_parent().get_node("Clipmap")

	var terrain_material: ShaderMaterial = get_parent().get_node("Clipmap").get_surface_override_material(0)

	var heightmap = terrain_material.get("shader_parameter/terrain_noise")
	var terrain_height: float = terrain_material.get("shader_parameter/height")
	
	var hmap_image = heightmap.noise.get_seamless_image(
		heightmap.get_width(),
		heightmap.get_height(),
	)

	var map_data = []

	for y in heightmap.get_height():
		for x in heightmap.get_width():
			map_data.push_back(terrain_height * hmap_image.get_pixel(x, y).r)

	print(heightmap.get_height())
	var shape = HeightMapShape3D.new()
	shape.map_width = heightmap.get_height()
	shape.map_depth = heightmap.get_width()
	shape.map_data = map_data

	var collision: CollisionShape3D = get_node("Shape")
	collision.shape = shape

