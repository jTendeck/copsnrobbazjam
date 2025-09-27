extends Control

@onready var button = $Panel/VSplitContainer/Button
@onready var text_label = $Panel/VSplitContainer/HSplitContainer/RichTextLabel
@onready var line_edit = $Panel/VSplitContainer/HSplitContainer/LineEdit
@onready var player_join_label = $Panel/PlayerJoinLabel
@onready var refresh_button = $Panel/RefreshButton
@onready var button_sound = $ButtonSound
@onready var key_sound = load("res://assets/sound/sfx/key_hit.wav")

var is_hosting = false


func _on_host_game_check_box_toggled(toggled_on: bool) -> void:
	
	
	
	if toggled_on:
		
		is_hosting = true
		
		button.text = "Start Game"
		
		text_label.text = "Game Code:"
		
		line_edit.editable = false
		line_edit.placeholder_text = ""
		line_edit.text = generate_text(6)
		
		player_join_label.visible = true
		
		refresh_button.visible = true
		
	else:
		
		is_hosting = false
		
		button.text = "Join Game"
		
		text_label.text = "Enter Code:"
		
		line_edit.editable = true
		line_edit.text = ""
		line_edit.placeholder_text = "ABC123"
		
		player_join_label.visible = false
		player_join_label.text = "Players: " + str(GlobalVariables.current_player_number) + "/4"
		
		refresh_button.visible = false
		
	
###PLACEHOLDER CODE UNTIL CHRIS MULTIPLAYER###
func generate_text(length: int) -> String:
	var charset := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	var text := ""
	for i in length:
		var idx := rng.randi_range(0, charset.length() - 1)
		text += charset[idx]
	return text


func _on_refresh_button_pressed() -> void:
	
	
	if refresh_button.visible:
		
		line_edit.text = generate_text(6)
	


func _on_line_edit_text_changed(new_text: String) -> void:
	
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = key_sound
	player.play()
	player.connect("finished", Callable(player, "queue_free"))
	
	print("Sound Played")

	line_edit.text = new_text.to_upper()
	line_edit.caret_column = new_text.length() 


func _on_button_pressed() -> void:
	
	if is_hosting:
		
		SignalManager.host_game_pressed.emit()
		
	else:
		
		SignalManager.join_game_pressed.emit()
