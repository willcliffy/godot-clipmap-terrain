extends CharacterBody3D

@onready var camera = $CameraBase/Camera3D

const MOVE_SPEED = 10
const CAMERA_ZOOM_SPEED = 10

func _physics_process(delta):
	var move_direction = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		move_direction.z -= 1
	if Input.is_action_pressed("move_backwards"):
		move_direction.z += 1
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1

	move_direction = move_direction.normalized()
	move_and_collide(move_direction * MOVE_SPEED * delta)

func _input(event):
	if not event is InputEventMouseButton:
		return

	var camera_zoom = 0
	if event.is_action_pressed("camera_zoom_in"):
		camera_zoom -= 1
	elif event.is_action_pressed("camera_zoom_out"):
		camera_zoom += 1
	camera.position.y += CAMERA_ZOOM_SPEED * camera_zoom
