extends FloatableBody3D

var health = 100;

@export 
var player_path: NodePath

@onready
var player = get_node(player_path)

@export
var CANNON_BALL_SCENE: PackedScene

@export
var CANNON_BALL_SPAWN_PATH: NodePath

@onready
var cannon_ball_spawn_path = get_node(CANNON_BALL_SPAWN_PATH)

@onready
var attack_timer = $AttackTimer

func dir_to_player():
	return global_position.direction_to(player.global_position)

func angle_to_player():
	return global_position.angle_to(player.global_position)

func die():
	print("dead")
	queue_free()

func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("cannonball"):
		body.impact()
		health -= 25
		mass+=0.025
		if health < 0:
			attack_timer.autostart = false;
			attack_timer.stop()
			mass = 1.0;
			var timer = get_tree().create_timer(2.0).connect("timeout", die)


var speed: float = 0.1

func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step

func _integrate_forces(state):
	var target_position = player.global_transform.origin
	look_follow(state, global_transform, target_position)


func _on_attack_timer_timeout() -> void:
	var ball = CANNON_BALL_SCENE.instantiate()
	cannon_ball_spawn_path.add_child(ball)
	ball.initialize(
		global_position + Vector3.UP * 3,
		 dir_to_player() * 2000 + Vector3.UP * global_position.distance_to(player.global_position)*10 + 100*Vector3(-1+randf()*2, -1+randf()*2,-1+randf()*2),
		 Enums.TargetTeam.PLAYER)
