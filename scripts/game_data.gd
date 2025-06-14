extends Node
var destroyed_enemies = 0
var time_start = 0

func measure_start():
	time_start = Time.get_unix_time_from_system()
	destroyed_enemies = 0

func get_secs_elapsed():
	return Time.get_unix_time_from_system() - time_start 
