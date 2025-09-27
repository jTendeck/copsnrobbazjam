extends Control

@onready var button_sound = $ButtonSound

func _on_resume_button_button_up() -> void:
	
	self.visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
				
func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		self.visible = false
	else:
		get_tree().paused = true
		self.visible = true


func _on_resume_button_pressed() -> void:
	button_sound.play()
