extends Node3D

@onready var display: Label = get_node("UI/Display")
@onready var clipmap_mesh: MeshInstance3D = get_node("Map/Clipmap")
@onready var player: CharacterBody3D = get_node("Player")

const div = 400
const snap_step_vector = Vector3()

const DIST_TO_SNAP = 20

var last_snap_position: Vector3

func _ready():
	snap()
	last_snap_position = player.global_transform.origin


func _process(_delta):
	# TODO - check this on a timer instead of in process maybe?
	if last_snap_position.distance_to(player.global_transform.origin) < DIST_TO_SNAP:
		return

	snap()
	last_snap_position = player.global_transform.origin


func snap():
	var player_pos = player.global_transform.origin.snapped(snap_step_vector)
	clipmap_mesh.global_transform.origin.x = player_pos.x
	clipmap_mesh.global_transform.origin.z = player_pos.z
	clipmap_mesh.get_surface_override_material(0).set("shader_parameter/uv", Vector2(player_pos.x, player_pos.z))
	display.text = str(clipmap_mesh.get_surface_override_material(0).get("shader_parameter/uv")) + "\n" + str(player_pos)
