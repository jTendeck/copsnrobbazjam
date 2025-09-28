extends Control

@onready var button_sound = $ButtonSound



func _on_resume_button_button_up() -> void:
	get_tree().paused = false
	self.visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):

		self.visible = not self.visible
		get_tree().paused = not get_tree().paused


func _on_resume_button_button_down() -> void:
	button_sound.play()
