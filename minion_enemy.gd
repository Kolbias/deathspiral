extends RigidBody2D

var vel = Vector2(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))

func destroy():
	GameGlobals.emit_signal("enemy_killed")
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	$Sprite2D.hide()
	$CPUParticles2D.emitting = true
	await $CPUParticles2D.finished
	queue_free()

func _process(delta: float) -> void:
	rotation = 0.0
	linear_velocity = vel
