extends Node2D

@onready var child_count = get_child_count();
# Called when the node enters the scene tree for the first time.
@export var player_scene : PackedScene;
func _ready() -> void:
	#Get spawn number
	var spawn_point_number = get_spawn_point();	
	print("spawn point number is: ", spawn_point_number);
	print("child count is: ", child_count);
	var count = 1;
	
	for child in get_children():
		print("Child node name:", child.name);
		print("child: ", count);
		# You can perform actions on each child node here
		# For example, check its type:
		if child is Node2D:
			print("This child is a Node2D!");
			if count == spawn_point_number:
				spawn_player(child);
				break;
		count = count + 1;


#Picks a random number between one and the child count
func get_spawn_point(): 
	var rng = RandomNumberGenerator.new();
	return rng.randi_range(1,child_count);

# Add player to spawn_point node "spawning the player" in game.
func spawn_player(player_spawn : Node2D):
	#Logic add the player scene to the child player_spawn promatically.
	player_spawn.spawn(player_scene);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
