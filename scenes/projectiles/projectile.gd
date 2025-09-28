extends RigidBody2D
class_name Projectile

const DESPAWN_TIME : float = 10.0

func _ready() -> void:
	var t : Timer = Timer.new()
	t.wait_time = DESPAWN_TIME
	t.timeout.connect(_on_despawn_timeout)
	add_child(t)
	t.start()
	
func _on_despawn_timeout():
	queue_free()