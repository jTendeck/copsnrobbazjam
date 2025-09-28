extends Area2D

@export var robber_owner : JtPlayer

@onready var pickup_timer : Timer = $PickupTimer

var money_bag : MoneyBag

func _on_pickup_timer_timeout():
	if (!robber_owner.enabled):
		pickup_timer.stop()
		return
	if (!money_bag.being_carried):
		money_bag.being_carried = true
		SignalManager.money_picked_up.emit(robber_owner, money_bag)

func _on_area_entered(area:Area2D):
	if (!robber_owner.enabled):
		pickup_timer.stop()
		return
	if (area is MoneyBag):
		money_bag = area as MoneyBag
		if (!money_bag.being_carried):
			SignalManager.player_picking_up_money.emit(robber_owner)
			pickup_timer.start()

func _on_area_exited(area:Area2D):
	if (area is MoneyBag):
		money_bag = null
		SignalManager.player_stopped_picking_up_money.emit(robber_owner)
		pickup_timer.stop()
