extends Node2D
class_name WeaponComponent


@export var projectile : PackedScene
@export var fire_location : Marker2D
@export var projectile_speed : float = 500.0
@export var add_parent_velocity : bool = false
@export var parent_velocity : float = 0.0
@export var accuracy : float = 2.0
@export var fire_direction_is_parent_rotation : bool = true
@export var direction : float
@export var firing : bool
@export var time_between_shots : float = 1.0
@export var can_reload : bool = true
@export var infinite_ammo : bool = false
@export var reload_time : float = 1.0
#@export var ammo_gained_per_reload_cycle : int = 1
@export var number_of_mags : int = 5
#@export var gain_all_ammo_on_reload : bool = true
@export var projectiles_per_mag : int = 5 
#@export var current_projectile_count : int = 5
@export var shoot_sfx : AudioStreamPlayer
@export var weapon_empty_sfx : AudioStreamPlayer
@export var automatic_reload_on_empty_mag : bool = false
@export var shooter_is_parent : bool = true
@export var shooter : JtPlayer

@onready var reload_timer : Timer = $ReloadTimer
@onready var shoot_cooldown_timer : Timer = $ShootCooldownTimer

var can_fire : bool = true
var current_mag_index : int = 0
var mags : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	reload_timer.wait_time = reload_time
	shoot_cooldown_timer.wait_time = time_between_shots
	if number_of_mags <= 0:
		number_of_mags = 1
	
	mags.resize(number_of_mags)
	mags.fill(projectiles_per_mag)

func _process(_delta):
	if mags[current_mag_index] <= 0 or !(can_fire and firing):
		return
		
	var fire_dir: float = direction
	if fire_direction_is_parent_rotation and get_parent() is Node2D:
		var parent : Node2D = get_parent() as Node2D
		fire_dir = parent.rotation
	
	var accuracy_rad: float = deg_to_rad(accuracy)
	var applied_accuracy: float = randf_range(-accuracy_rad, accuracy_rad)
	var applied_projectile_speed : float = projectile_speed
	if add_parent_velocity:
		applied_projectile_speed += parent_velocity
	
	if shoot_sfx != null:
		shoot_sfx.play()
	
	SignalManager.player_fire.emit(shooter, projectile, fire_location.global_position, fire_dir + applied_accuracy, Vector2(applied_projectile_speed, 0))
	
	can_fire = false
	shoot_cooldown_timer.start()
	
	if infinite_ammo or projectiles_per_mag <= 0:
		return
		
	mags[current_mag_index] -= 1
	
	if mags[current_mag_index] <= 0 && automatic_reload_on_empty_mag:
		reload()
	

func _on_reload_timer_timeout():
	can_fire = true
	current_mag_index = mags.find(mags.max())
	print("values of mags: " + str(mags))


func _on_shoot_cooldown_timer_timeout():
	can_fire = true


func reload():
	shoot_cooldown_timer.stop()
	if !can_reload:
		can_fire = true
		return
	reload_timer.start()


func add_mag(projectiles : int = -1):
	number_of_mags += 1
	mags.append(projectiles if projectiles > -1 else projectiles_per_mag)


func add_ammo_to_current_mag(amount : int):
	mags[current_mag_index] += amount