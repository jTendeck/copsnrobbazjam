extends Control


func _on_resume_button_button_up() -> void:
	SignalManager.resume_game_pressed.emit()
