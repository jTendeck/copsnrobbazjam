extends CharacterBody2D
class_name JtPlayer

@export var enabled : bool = true

@export var health : int = 3

@export var non_aiming_walk_speed : float = 400.0
@export var accelerate_walk_rate : float = 500
@export var decelerate_walk_rate : float = 500
@export var aiming_walk_speed : float = 300.0
@export var carry_walk_speed_penalty : float = 75

@export var non_aiming_accuracy : float = 10.0
@export var aiming_accuracy : float = 3.0
@export var carry_accuracy_penalty : float = 2

@export var primary_weapon : WeaponComponent
@export var secondary_weapon : WeaponComponent

@export var non_aiming_rotation_speed : float = 10
@export var aiming_rotation_speed : float = 3.0
@export var carry_rotation_penalty : float = 2

@export var hurt_box : Area2D

@export var fire_hurt_timer : Timer
@export var money_carry_location : Marker2D

var current_walk_speed : float
var current_accuracy : float
var current_rotation_speed : float

var aiming: bool

var on_fire : bool = false

var money : MoneyBag

func _ready() -> void:
	SignalManager.money_picked_up.connect(_on_money_picked_up)
	

func _physics_process(delta):
	if !enabled:
		return
	
	aiming = Input.is_action_pressed("aim")
	
	current_walk_speed = aiming_walk_speed if aiming else non_aiming_walk_speed
	current_accuracy = aiming_accuracy if aiming else non_aiming_accuracy
	current_rotation_speed = aiming_rotation_speed if aiming else non_aiming_rotation_speed
	
	var got_money : bool = money != null
	
	var speed_penalty: float = carry_walk_speed_penalty if got_money else 0.0
	var accuracy_penalty: float = carry_accuracy_penalty if got_money else 0.0
	var rotation_penalty: float = carry_rotation_penalty if got_money else 0.0
	
	current_walk_speed -= speed_penalty
	current_accuracy += accuracy_penalty
	rotation_penalty -= rotation_penalty
	
	# Walk
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * current_walk_speed, accelerate_walk_rate * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, decelerate_walk_rate * delta)

	# Slowly rotate towards the mouse
	var mouse_pos: Vector2 = get_global_mouse_position()
	var direction: float = (mouse_pos - global_position).angle()
	rotation = lerp_angle(rotation, direction, current_rotation_speed * delta)
	
	# Handle weapons
	if primary_weapon != null:
		if Input.is_action_pressed("reload"):
			primary_weapon.reload()
		primary_weapon.accuracy = current_accuracy
		primary_weapon.firing = Input.is_action_pressed("primary_shoot")
		
	# Handle weapons
	if secondary_weapon != null:
		secondary_weapon.accuracy = current_accuracy
		secondary_weapon.firing = Input.is_action_pressed("secondary_shoot")
	
	move_and_slide()


func kill_player() -> void:
	enabled = false
	fire_hurt_timer.stop()
	if primary_weapon != null:
		primary_weapon.firing = false
	if secondary_weapon != null:
		secondary_weapon.firing = false
	if (money != null):
		money.being_carried = false
	SignalManager.player_killed.emit(self)


func _on_hurtbox_hit(body : Node2D):
	if (body is Bullet):
		var bul: Bullet = body as Bullet
		SignalManager.player_hit.emit(self, bul)
		take_damage(1)
		bul.call_deferred("queue_free")
		
	if (body is Area2D):
		print("on fire!")
		var a: Area2D = body as Area2D
		if a.get_collision_layer_value(6):
			on_fire = true
			fire_hurt_timer.start()


func _on_hurtbox_body_exited(body:Node2D):
	if (body is Area2D):
		print("not on fire!")
		var a: Area2D = body as Area2D
		if a.get_collision_layer_value(6):
			on_fire = false
			fire_hurt_timer.stop()


func take_damage(amount : int):
	health -= amount
	if health <= 0:
		kill_player()


func _on_fire_hurt_timer_timeout():
	print("taking fire damage!")
	take_damage(1)


func _on_money_picked_up(robber_owner : JtPlayer, money_bag : MoneyBag):
	if (robber_owner == self):
		money = money_bag
		money.reparent(self)
		if (money_carry_location != null):
			money_bag.global_position = money_carry_location.global_position
		
