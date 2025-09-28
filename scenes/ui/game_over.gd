extends Node2D


@onready var button_sound = $ButtonSound
@onready var lobby_menu = preload("res://scenes/ui/lobby.tscn")
@onready var main_menu = preload("res://scenes/ui/mainMenu.tscn")

func _on_play_again_button_down() -> void:
	button_sound.play()


func _on_play_again_button_up() -> void:
	
	await button_sound.finished
	
	get_tree().change_scene_to_packed(lobby_menu)
	


func _on_quit_button_down() -> void:
	button_sound.play()


func _on_quit_button_up() -> void:
	
	await button_sound.finished
	
	get_tree().change_scene_to_packed(main_menu)
