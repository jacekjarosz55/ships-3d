extends RigidBody3D

func impact():
	freeze = true
	collision_layer = 0
	$MeshInstance3D.hide()
	$BangSprite3D.show()
	$BangTimer.start()


func _physics_process(delta: float) -> void:
	if global_position.y < -10:
		queue_free()
		
func initialize(position: Vector3, velocity: Vector3, target: Enums.TargetTeam):
	set_collision_layer_value(4, target == Enums.TargetTeam.PLAYER)
	set_collision_layer_value(3, target == Enums.TargetTeam.ENEMY)
		
	global_position = position
	apply_central_force(velocity);
	


func _on_bang_timer_timeout() -> void:
	queue_free()
