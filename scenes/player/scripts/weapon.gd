extends Node2D

@export var projectile_scene : PackedScene;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#makes the new projectile and fires it with the velocity.
func shoot():
	print("firing projectile")
	var new_projectile = projectile_scene.instantiate();
	
	#make a new scene at the root of the tree for just the currently fired projectile.
	get_tree().current_scene.add_child(new_projectile);
	
	#global transform for the parent object (should be the player);
	var forward_vector_global = get_global_transform().x;
	
	#rotate projectile to match player is looking at
	new_projectile.look_at(forward_vector_global);
	
	new_projectile.position = get_parent().global_position + (100 * forward_vector_global);
	
	
	#call fire on the projectile instance
	new_projectile.fire(forward_vector_global);
	
	#Profit???
	pass;
