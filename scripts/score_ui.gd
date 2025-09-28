extends Control

@onready var player_name_text = $HSplitContainer/PlayerName
@onready var player_score_text = $HSplitContainer/Score

func _ready() -> void:
	player_name_text.text = "P" + str(self.get_meta("player_num"))
	player_score_text.text = str(GlobalVariables.players[self.get_meta("player_num")-1].score)
	
func update_score():
	player_score_text.text = str(GlobalVariables.players[self.get_meta("player_num")-1].score)
