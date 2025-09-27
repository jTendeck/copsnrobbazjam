extends Node2D

@onready var pause_menu = $PauseMenu

func _ready() -> void:
	pause_menu.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
				
func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		pause_menu.visible = false
	else:
		get_tree().paused = true
		pause_menu.visible = true
		
