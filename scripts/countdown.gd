extends Node2D

var time_left = 60

var current_minute = 0
var current_second = 0

var minutes_string = "00"
var seconds_string = "00"


@onready var label = $RichTextLabel



func update_label():
	
	#ignored warning because i want int division here
	@warning_ignore("integer_division")
	current_minute = int(GlobalVariables.global_time) / 60
	current_second = int(GlobalVariables.global_time) % 60
	
	minutes_string = str(current_minute) if current_minute > 9 else "0" + str(current_minute)
	seconds_string = str(current_second) if current_second > 9 else "0" + str(current_second)

	label.text = minutes_string + ":" + seconds_string
