extends Control

@onready
var healthbar = $HealthBarStack/HealthBar

@onready 
var angle_label = $AngleLabel

@onready
var compass: TextureRect = $CompassAnchor/Compass


@onready
var camera = get_viewport().get_camera_3d()

@onready
var player = $"../PlayerShip"

func _process(delta:float) -> void:
	angle_label.text = "Angle: %f" % camera.global_rotation_degrees.y
	compass.rotation = camera.global_rotation.y
	healthbar.max_value = player.HEALTH
	healthbar.value = player.health
	if player.health <= 0:
		$GameOverText.show()
