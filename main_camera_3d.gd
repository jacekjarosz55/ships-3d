extends Node3D

@export
var SENSITIVITY = 0.001
@onready
var rotation_helper = $RotationHelper

@onready
var camera = $RotationHelper/MainCamera3D

@onready
var target_fov: float = camera.fov;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _process(delta: float) -> void:
	camera.fov = lerp(camera.fov, target_fov, 1 - 0.2 ** delta) 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		global_rotate(Vector3.UP, event.relative.x * -SENSITIVITY)
		rotation_helper.rotate_x(event.relative.y * SENSITIVITY)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_fov = min(100.0, target_fov + 2)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_fov = max(60.0, target_fov - 2)
			
	
