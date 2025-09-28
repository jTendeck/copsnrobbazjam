extends CharacterBody2D


const SPEED = 600.0

@onready var visibility_area : PointLight2D = $VisibilityArea


func _ready() -> void:
	set_multiplayer_authority(name.to_int())
	if !is_multiplayer_authority():
		visibility_area.visible = false


func _physics_process(delta):

	if !is_multiplayer_authority():
		return

	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
