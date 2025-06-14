extends Node

func start():
	$SpawnTimer.start()

@export
var spawn_path: NodePath
@export
var spawn_check_path: NodePath



@onready
var spawn_loc = get_node(spawn_path)

@onready
var spawn_check_loc = get_node(spawn_path)

var spawn_checker_scene = preload("res://scenes/enemy_spawn_checker.tscn")

@export
var MAX_ENEMIES = 10

func _on_spawn_timer_timeout() -> void:
	if len(spawn_check_loc.get_children()) > MAX_ENEMIES:
		return
	var inst = spawn_checker_scene.instantiate()
	inst.spawn_loc = spawn_loc
	spawn_check_loc.add_child(inst)
	inst.global_position = Vector3(randf()*100, 0, randf()*100)
	inst.run_check()
	
