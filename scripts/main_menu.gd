extends Node2D

@onready var buttonSound = $Click

@onready var lobby_menu = load("res://scenes/ui/lobby.tscn")

func _ready() -> void:
	pass


func _on_quit_button_button_up() -> void:
	buttonSound.play()


func _on_play_button_button_up() -> void:
	buttonSound.play()
	lobby_menu.instantiate()
