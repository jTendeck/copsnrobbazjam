extends RigidBody2D

#starting with a hardcoded vector, this direction needs to be set before impulse is called
@onready var directionVector = Vector2.RIGHT;
@export var SPEED = 700;

# Called when the node enters the scene tree for the first time.
# turn off gravity and move it torward vector with speed
func _ready() -> void:
	gravity_scale = 0;
	directionVector = directionVector * SPEED;
	apply_impulse(directionVector);



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;


func _on_body_entered(body: Node) -> void:
	print("I hit something!!!!!");
	queue_free();
	pass # Replace with function body.
