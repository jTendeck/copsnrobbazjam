extends CharacterBody2D

@export var speed = 10;
@export var rotation_weight = 1.5;
@export var lerp_speed = .75;
var last_mouse_pos = Vector2.ZERO;

var rotation_direction = 0

func get_input():
	var input_direction = velocity + Input.get_vector("left","right","up","down") * speed;
	
	global_transform = global_transform.translated(lerp(velocity,input_direction,lerp_speed));
	
	#lerp rotation speed
	#easiest way to do this is to lerp last postition to current
	#I am sorry for this
	if last_mouse_pos == Vector2.ZERO:
		last_mouse_pos = get_global_mouse_position();
		
	look_at(lerp(last_mouse_pos,get_global_mouse_position(),rotation_weight));
	
	last_mouse_pos = get_global_mouse_position();
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	
