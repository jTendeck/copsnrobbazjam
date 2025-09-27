extends Node2D

var time_left = 60

var current_minute = 0
var current_second = 0

var minutes_string = "00"
var seconds_string = "00"

@onready var timer = $Timer
@onready var label = $RichTextLabel

func _ready():
	timer.wait_time = 1
	timer.start()
	update_label()

func _on_timer_timeout():
	time_left -= 1
	
	update_label()
	
	if time_left <= 0:
		timer.stop()
		#here is where we signal game over

func update_label():
	
	#ignored warning because i want int division here
	@warning_ignore("integer_division")
	current_minute = int(time_left) / 60
	current_second = int(time_left) % 60
	
	minutes_string = str(current_minute) if current_minute > 9 else "0" + str(current_minute)
	seconds_string = str(current_second) if current_second > 9 else "0" + str(current_second)

	label.text = minutes_string + ":" + seconds_string
