extends CharacterBody2D

@export var speed = 100.0

var dir_array = [Vector2(-speed, speed), Vector2(speed, speed), Vector2(speed, -speed), Vector2(-speed, -speed)]

@onready var dir = dir_array.pick_random().normalized() * speed

func _physics_process(delta: float) -> void:
	$Sprite2D.rotate(-10.0)
	velocity = dir
	var collision = move_and_collide(dir * delta)
	if collision:
		print("Collided with surface")
		print("Collider:", collision.get_collider())
		print("Normal:", collision.get_normal())
		dir = dir.bounce(collision.get_normal())
		dir = dir.normalized() * speed
		%CPUParticles2D.emitting = true
	else:
		%CPUParticles2D.emitting = false
	print(dir)
		
