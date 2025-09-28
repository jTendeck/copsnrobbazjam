extends Area2D
class_name MoneyBag

var being_carried : bool
var carrier : JtPlayer
@onready var win_timer : Timer = $WinTimer

func _ready() -> void:
	SignalManager.money_picked_up.connect(_on_money_picked_up)
	SignalManager.money_dropped.connect(_on_money_dropped)
	
func _on_money_dropped(money_bag: MoneyBag):
	if (money_bag == self):
		rotation = 0
		being_carried = false
		carrier = null

	
func _on_money_picked_up(by: JtPlayer, moneybag: MoneyBag):
	if (moneybag == self and by.enabled):
		being_carried = true
		carrier = by
		

func _on_area_entered(area:Area2D):
	win_timer.start()


func _on_win_timer_timeout():
	if (being_carried):
		SignalManager.money_delivered.emit(carrier)


func _on_area_exited(area:Area2D):
	win_timer.stop()
	
func drop():
	SignalManager.money_dropped.emit(carrier)
