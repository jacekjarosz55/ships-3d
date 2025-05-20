extends Node3D

@export
var SENSITIVITY = 0.001
@onready
var rotation_helper = $RotationHelper

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		global_rotate(Vector3.UP, event.relative.x * -SENSITIVITY)
		rotation_helper.rotate_x(event.relative.y * SENSITIVITY)
