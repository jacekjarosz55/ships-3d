extends Node3D

const SPAWN_RANDOM := 40.0



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# We only need to spawn players on the server.
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	# Spawn already connected players.
	for id in multiplayer.get_peers():
		add_player(id)

	# Spawn the local player unless this is a dedicated server export.
	if not OS.has_feature("dedicated_server"):
		add_player(1)
	$EnemySpawner.start()
	GameData.measure_start()

func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


@onready 
var ui = $UI

func notify_players_to_enemies():
	for enemy in $Enemies.get_children():
		enemy.update_players($Players.get_children() as Array[FloatableBody3D])

func add_player(id: int):
	var character = preload("res://scenes/player_ship.tscn").instantiate()
	# Set player id.
	character.player = id
	# Randomize character position.
	var pos := Vector2.from_angle(randf() * 2 * PI)
	character.position = Vector3(pos.x * SPAWN_RANDOM * randf(), 0, pos.y * SPAWN_RANDOM * randf())
	character.name = str(id)
	
	
	$Players.add_child(character, true)
	notify_players_to_enemies()
	if get_multiplayer_authority() == id:
		var ui = $UI
		var on_local_player_ready = func():
			ui.player = character
			ui.camera = get_viewport().get_camera_3d()
		if character.is_node_ready():
			ui.player = character
			ui.camera = get_viewport().get_camera_3d()
		else:
			character.connect("ready", on_local_player_ready)

func del_player(id: int):
	if not $Players.has_node(str(id)):
		return
	var player_to_remove: Node = $Players.get_node(str(id))
	player_to_remove.connect("tree_exited", notify_players_to_enemies)
	player_to_remove.queue_free()
	
	
