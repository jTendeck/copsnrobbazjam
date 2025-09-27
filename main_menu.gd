extends Control

@onready var lobby_menu = load("res://scenes/ui/lobby.tscn").instantiate()

func _on_start_game_button_up() -> void:
	get_tree().root.add_child(lobby_menu)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = lobby_menu
