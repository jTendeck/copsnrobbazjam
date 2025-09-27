extends Node2D
@onready var parent = get_parent();
#Getting grenade and weapon nodes.
@onready var node_weapon = get_node("Weapon");
@onready var node_Grenade = get_node("Grenade");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("grenade"):
		#call throw on the grenade node
		pass;
	if Input.is_action_just_pressed("fire"):
		node_weapon.shoot();
		pass;
	
