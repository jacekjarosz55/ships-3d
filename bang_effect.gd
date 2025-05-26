extends Sprite3D


func _on_die_timer_timeout() -> void:
	queue_free()
