extends Area2D

@onready var smoke_particles : CPUParticles2D = $Smoke

func _on_burn_timer_timeout():
	smoke_particles.emitting = false

func _on_smoke_finished():
	call_deferred("queue_free")
