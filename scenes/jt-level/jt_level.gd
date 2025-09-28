extends Node2D

@export var robber_scene : PackedScene
@export var police_scene : PackedScene

@onready var money_bag: MoneyBag = $MoneyBag


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.player_fire.connect(_on_player_fire)
	SignalManager.player_killed.connect(_on_player_killed)
	SignalManager.player_hit.connect(_on_player_hit)
	SignalManager.spawn_scene.connect(_on_spawn_scene)
	SignalManager.money_delivered.connect(_on_money_delivered)
	SignalManager.player_connected.connect(_on_player_connected)
	
	

func _on_player_fire(_projectile_owner: JtPlayer, projectile: PackedScene, location: Vector2, angle: float, velocity: Vector2) -> void:
	var proj: Node = projectile.instantiate()
	print("firing in level!")
	if proj is Projectile:
		proj.position = location
		proj.rotation = angle
		proj.linear_velocity = velocity.rotated(angle)
		add_child(proj)
		
func _on_player_killed(player: JtPlayer):
	print(player.name + " killed!")
	if (player.money != null):
		SignalManager.money_dropped.emit(player.money)
		print ("Money dropped!")
		player.money.call_deferred("reparent", self)
	
func _on_player_hit(player: JtPlayer, hit_by: Projectile):
	print(player.name + " hit by " + hit_by.name)
	
func _on_spawn_scene(scene: PackedScene, location: Vector2):
	var n: Node = scene.instantiate()
	print("in on spawn scene in level")
	if n is Node2D:
		var n2 : Node2D = n as Node2D
		n2.position = location
		print("spawned " + n2.name + " at " + str(n2.position))
		add_child(n2)


func _on_money_delivered(by: JtPlayer):
	money_bag.position = random_screen_position()
	SignalManager.money_dropped.emit(money_bag)
	money_bag.call_deferred("reparent", self)
	print("Money delivered by : " + by.name + "\nNew Position: " + str(money_bag.position))
		

func remove_and_clone(obj: Node2D, new_position : Vector2 ) -> void:
	var clone = obj.duplicate()
	obj.get_parent().add_child(clone)
	clone.position = new_position
	obj.queue_free()
	
	
func random_screen_position() -> Vector2:
	var viewport_size = get_viewport().get_visible_rect().size
	var x = randf_range(0, viewport_size.x)
	var y = randf_range(0, viewport_size.y)
	return Vector2(x, y)


var spawn_cop: bool
func _on_player_connected(id: int) -> void:
	if (GlobalVariables.all_players.size() >= GlobalVariables.MAX_PLAYERS):
		print("Too many players; unable to join!")
		return
	var player : JtPlayer
	if (spawn_cop):
		player = police_scene.instantiate()
	else:
		player = robber_scene.instantiate()
	spawn_cop = !spawn_cop
	player.name = str(id)
	player.enabled = false
	GlobalVariables.add_player(player)
	
	

