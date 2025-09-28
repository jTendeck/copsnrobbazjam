extends Node2D

@onready var buttonSound = $Click

@onready var lobby_menu = preload("res://scenes/ui/lobby.tscn")

func _ready() -> void:
	pass



func _on_quit_button_button_down() -> void:
	
	buttonSound.play()
	
	


func _on_play_button_button_down() -> void:
	
	buttonSound.play()
	
	
func _on_play_button_button_up() -> void:
	
	await buttonSound.finished
	get_tree().change_scene_to_packed(lobby_menu)


func _on_quit_button_button_up() -> void:
	await buttonSound.finished
	
	get_tree().quit()
