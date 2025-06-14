extends Control

@onready
var healthbar = $HealthBarStack/HealthBar

@onready
var cooldown_bar = $CooldownBar

@onready
var compass: TextureRect = $CompassAnchor/Compass



var camera = null
var player = null


func _process(delta:float) -> void:
	if player == null:
		return
	compass.rotation = camera.global_rotation.y
	healthbar.max_value = player.HEALTH
	healthbar.value = player.health
	var cooldown_timer: Timer = player.shoot_cooldown_timer
	cooldown_bar.value = cooldown_timer.time_left /  cooldown_timer.wait_time
	
	
	if player.health <= 0:
		$GameOverText.show()
