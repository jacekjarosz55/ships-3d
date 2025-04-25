extends Node3D

@onready
var player = $"..";

@export
var SENSITIVITY = 0.001;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -SENSITIVITY);
