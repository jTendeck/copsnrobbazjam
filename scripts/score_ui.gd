extends Control

var player_num = 2
@onready var player_name_text = $HSplitContainer/PlayerName
@onready var player_score_text = $HSplitContainer/Score

func _ready() -> void:
	player_name_text.text = "P" + str(player_num)
	player_score_text.text = str(GlobalVariables.player_score[player_num-1])
	
