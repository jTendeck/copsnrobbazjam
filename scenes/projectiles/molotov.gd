extends Projectile

@export var explosion_scene : PackedScene

func _on_explode_timer_timeout():
	SignalManager.spawn_scene.emit(explosion_scene, position)
	call_deferred("queue_free")
