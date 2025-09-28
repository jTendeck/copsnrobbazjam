extends Projectile
class_name Bullet

func _on_body_entered(body:Node):
	call_deferred("queue_free")
