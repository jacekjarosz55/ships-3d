extends FloatableBody3D

@export
var MOVE_ACCEL = 0.1;
@export
var MOVE_MAX_SPEED = 0.2;

var move_speed = 0;

@export
var CANNON_BALL_SCENE: PackedScene

@onready
var camera = $CameraController/RotationHelper/MainCamera3D

@export
var ROT_SPEED = 0.05

@export
var HEALTH = 200.0

@onready
var shoot_cooldown_timer = $ShootCooldownTimer

@export
var CANNONBALL_SPAWN_PATH: NodePath

@onready
var cannonball_spawn = get_node(CANNONBALL_SPAWN_PATH)

signal health_changed(health: float, max_health: float)

var health : set = _set_health

func shoot():
	shoot_cooldown_timer.start()
	var ball  = CANNON_BALL_SCENE.instantiate()
	cannonball_spawn.add_child(ball)
	ball.initialize(global_position + camera.get_global_transform().basis.y*4, -camera.get_global_transform().basis.z*2000, Enums.TargetTeam.ENEMY)
	
func _ready():
	health = HEALTH
	super()

func _set_health(val):
	health = val
	if health < 0:
		mass = 2.0;
	emit_signal("health_changed",health, HEALTH)

func _physics_process(delta: float) -> void:
	move_speed = move_toward(move_speed, 0, 0.05 * delta)
	if health > 0:
		if Input.is_action_pressed("forward"): 
			move_speed = move_toward(move_speed, MOVE_MAX_SPEED, MOVE_ACCEL * delta)
		if Input.is_action_pressed("backward"):
			move_speed = move_toward(move_speed, -MOVE_MAX_SPEED*0.6, MOVE_ACCEL * delta)
		if Input.is_action_pressed("left"):
			angular_velocity.y+=ROT_SPEED*move_speed/MOVE_MAX_SPEED;
		if Input.is_action_pressed("right"):
			angular_velocity.y-=ROT_SPEED*move_speed/MOVE_MAX_SPEED;
		if Input.is_action_just_pressed("shoot") and shoot_cooldown_timer.is_stopped():
			shoot()
	linear_velocity += global_transform.basis * Vector3(0,0,move_speed)
	super(delta)

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("cannonball"):
		body.impact()
		health -= 10.0;
