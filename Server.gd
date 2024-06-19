extends Node

const PORT = 1234
const MAX_CONNECTIONS = 100

var _players_spawn_node
var connected_player_ids = []

func _ready():
	start_server()
	_players_spawn_node = get_tree().get_current_scene().get_node("Players")

func start_server():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.multiplayer_peer = peer
	print("Server started")

func add_player_character(player_id):
	connected_player_ids.append(player_id)
	var player_to_add = preload("res://player.tscn").instantiate()
	player_to_add.player_id = player_id
	player_to_add.name = str(player_id)
	_players_spawn_node.add_child(player_to_add, true)

func _on_player_connected(player_id):
	print("Player " + str(player_id) + " connected")
	add_player_character(player_id)

func _on_player_disconnected(player_id):
	print("Player " + str(player_id) + " disconnected")
	if not _players_spawn_node.has_node(str(player_id)):
		return
	_players_spawn_node.get_node(str(player_id)).queue_free()


