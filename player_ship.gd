extends FloatableBody3D

@export
var MOVE_ACCEL = 0.1;
@export
var MOVE_MAX_SPEED = 0.2;

var move_speed = 0;


@export
var ROT_SPEED = 0.05;

@export
var HEALTH = 40.0;



signal health_changed(health: float, max_health: float)


var health : set = _set_health
func _ready():
	health = HEALTH
	super()

func _set_health(val):
	health = val
	mass = 1.0 
	emit_signal("health_changed",health, HEALTH)

func _physics_process(delta: float) -> void:
	move_speed = move_toward(move_speed, 0, 0.05 * delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		health -= 10.0;

	if Input.is_action_pressed("forward"): 
		move_speed = move_toward(move_speed, MOVE_MAX_SPEED, MOVE_ACCEL * delta)
	if Input.is_action_pressed("backward"):
		move_speed = move_toward(move_speed, -MOVE_MAX_SPEED*0.6, MOVE_ACCEL * delta)

	linear_velocity += global_transform.basis * Vector3(0,0,move_speed)
		
	if Input.is_action_pressed("left"):
		angular_velocity.y+=ROT_SPEED*move_speed/MOVE_MAX_SPEED;
	if Input.is_action_pressed("right"):
		angular_velocity.y-=ROT_SPEED*move_speed/MOVE_MAX_SPEED;
	super(delta)
