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
	add_child(new_projectile);
	new_projectile.position = position;
	#get vector to fire towards
	var fire_vector = Vector2.RIGHT;
	#call fire on the projectile instance
	new_projectile.fire(fire_vector);
	
	#Profit???
	pass;
