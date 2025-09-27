extends Node2D

var player_scene : PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


#Called from the spawn manager, takes the player_scene PackedScene, 
#makes a new instance of player, and then sets the position of it to the spawn node.
func spawn(player_scene : PackedScene):
	var newPlayer = player_scene.instantiate();
	print("spawning player at: ", name, " ", newPlayer.name);
	newPlayer.position = position;
	add_child(newPlayer);
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
