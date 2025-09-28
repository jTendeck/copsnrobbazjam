# network.gd
extends Node

# Add signals to notify other parts of your game
signal player_connected(id)
signal player_disconnected(id)

const IP_ADDRESS : String = "localhost" # TODO need to get this dynamically
const PORT: int = 12000
#1883

var peer : ENetMultiplayerPeer

# Called when the node is added to the scene
func _ready():
	# Connect to multiplayer signals
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error != OK:
		print("Failed to create server.")
		return
	multiplayer.multiplayer_peer = peer
	print("Server started on port: ", PORT)
	# The server itself is a "player"
	emit_signal("player_connected", 1) # The server always has an ID of 1

func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(IP_ADDRESS, PORT)
	if error != OK:
		print("Failed to create client.")
		return
	multiplayer.multiplayer_peer = peer
	print("Client started, connecting to: ", IP_ADDRESS)

# --- Signal Callbacks ---
func _on_peer_connected(id: int):
	print(str(id), " connected.")
	SignalManager.player_connected.emit("player_connected", id)


func _on_peer_disconnected(id: int):
	print(str(id), " disconnected.")
	SignalManager.player_disconnected.emit("player_connected", id)
