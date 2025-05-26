extends StaticBody3D


func _on_ball_destroyer_body_entered(body: Node3D) -> void:
	if body.is_in_group("cannonball"):
		body.impact()
