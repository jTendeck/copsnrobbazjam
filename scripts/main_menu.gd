extends Node2D

@onready var buttonSound = $Click


func _on_quit_button_button_up() -> void:
	buttonSound.play()
	SignalManager.quit_button_pressed.emit()


func _on_play_button_button_up() -> void:
	buttonSound.play()
	SignalManager.play_button_pressed.emit()
