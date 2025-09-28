extends Node

var timer = Timer

@onready var countdown = $Countdown

@onready var game_over_screen = load("res://scenes/ui/Game_over.tscn").instantiate()

@onready var score_ui_p1 = $ScoreUIP1
@onready var score_ui_p2 = $ScoreUIP2
@onready var score_ui_p3 = $ScoreUIP3
@onready var score_ui_p4 = $ScoreUIP4


func _ready() -> void:
	
	#this  is gross
	if GlobalVariables.current_player_number < 4:
		
		score_ui_p4.visible = false
		
		if GlobalVariables.current_player_number < 3:
			
			score_ui_p3.visible = false

	
	###TIMER CODE###
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(_on_timer_timeout)

	timer.start()
	################
	
	
	
func _on_timer_timeout() -> void:
	GlobalVariables.global_time -= 1
	countdown.update_label()
	
	GlobalVariables.players[0].score += GlobalVariables.point_values["second"]
	GlobalVariables.players[2].score += GlobalVariables.point_values["second"]
	
	score_ui_p1.update_score()
	score_ui_p3.update_score()
	
	
	if GlobalVariables.global_time <= 0:
		timer.stop()
		get_tree().root.add_child(game_over_screen)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = game_over_screen

func _on_player_hit(player: GlobalVariables.Player, damage: int) -> void:
	
	player.health -= damage
	
	if player.health <= 0:
		SignalManager.emit_signal("kill_player",player)
