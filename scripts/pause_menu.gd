extends Control

@onready var game_scene = load("res://scenes/main.tscn").instantiate()

func _on_resume_button_button_up() -> void:
	
	SignalManager.resume_game_pressed.emit()
	
	get_tree().root.add_child(game_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = game_scene
