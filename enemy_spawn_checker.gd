extends Area3D

var enemy_scene = preload("res://enemy.tscn")
var spawn_loc = null

func spawn_enemy():
	var inst = enemy_scene.instantiate()
	spawn_loc.add_child(inst)
	inst.global_position = global_position
	
	print(inst.global_position)
	queue_free()
	
func run_check() -> void:
	if len(get_overlapping_areas()) == 0 and len(get_overlapping_bodies()) == 0:
		spawn_enemy()
