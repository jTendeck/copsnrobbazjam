extends Node2D

@onready var button = $click

func _on_play_pressed() -> void:
	button.play()
	get_tree().change_scene_to_file("res://main.tscn")#change scene to host scene

func _on_quit_pressed() -> void:
	button.play()
	get_tree().quit()
