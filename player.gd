extends CharacterBody2D

@export var speed = 100.0
@export var rotation_speed = 400.0
@export var launch_dir: Vector2
@onready var sprite: Sprite2D = $Sprite2D
@onready var particles: CPUParticles2D = %CPUParticles2D

var dir_array = [Vector2(-speed, speed), Vector2(speed, speed), Vector2(speed, -speed), Vector2(-speed, -speed)]
var dir : Vector2


func _ready() -> void:
	speed *= 1.50
	if launch_dir:
		dir = launch_dir 
		speed *= 2.0
	else:
		dir = dir_array.pick_random().normalized() * speed

func _physics_process(delta: float) -> void:
	sprite.rotation_degrees += (speed * 5) * delta
	#print(sprite.rotation)
	#print(speed)
	velocity = dir
	var collision = move_and_collide(dir * delta)
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		var my_speed = dir.length()
		var collider_vel = collider.get_real_velocity() if collider is CharacterBody2D else Vector2.ZERO
		var collider_speed = collider_vel.length()
		
		if collider.has_method("get_real_velocity"):
			collider_vel = collider.get_real_velocity()
		elif "velocity" in collider:
			collider_vel = collider.velocity
		if collider is CharacterBody2D and collider.is_in_group("spiral"):
			if my_speed > collider_speed:
				print("My Speed faster than colli")
				collider.velocity = -normal * my_speed 
			else:
				dir = normal * collider_speed
				speed = collider_speed # Update your speed variable too
		if collision.get_collider().is_in_group("paddle"):
			speed *= 1.2
		else:
			speed *= 0.7
		#print("Collided with surface")
		print("Collider:", collision.get_collider())
		
		dir = (dir - collider_vel).bounce(collision.get_normal()) + collider_vel
		#print("Normal:", collision.get_normal())
		#dir = dir.bounce(collision.get_normal())
		print("Collision Normal: " + str(collision.get_normal()))
		dir = dir.normalized() * speed
		particles.emitting = true
		var tween = create_tween()
		%PointLight2D.energy = 4.25
		tween.tween_property($PointLight2D, "energy", 0.0, 0.2)
	else:
		particles.emitting = false
		#$PointLight2D.hide()
	if speed <= 60.0:
		#print("too slow deleting")
		%CollisionShape2D.disabled = true
		%ExplosionParticles.emitting = true
		await %ExplosionParticles.finished
		queue_free()
	#print(speed)
		
