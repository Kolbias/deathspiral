extends RigidBody2D

@export var speed = 250.0 # RigidBodies need slightly higher values
@export var launch_dir: Vector2
@onready var sprite: Sprite2D = $Sprite2D
@onready var particles: CPUParticles2D = %CPUParticles2D

func _ready() -> void:
	
	var start_vel: Vector2
	if launch_dir:
		start_vel = launch_dir.normalized() * (speed * 2.0)
	else:
		var directions = [Vector2(-1, 1), Vector2(1, 1), Vector2(1, -1), Vector2(-1, -1)]
		start_vel = directions.pick_random().normalized() * speed
	
	linear_velocity = start_vel

func _process(delta: float) -> void:
	if linear_velocity.length() <= 100:
		var tween = create_tween()
		tween.tween_property(%SpeedLight, "color", Color(0.949, 0.0, 0.0, 1.0), 0.1)
	if linear_velocity.length() >= 100:
		var tween = create_tween()
		tween.tween_property(%SpeedLight, "color", Color(0.0, 0.773, 0.0, 1.0), 0.1)
	if linear_velocity.length() >= 1000:
		var tween = create_tween()
		tween.tween_property(%SpeedLight, "color", Color(1.0, 0.773, 0.0, 1.0), 0.1)
	

func _physics_process(delta: float) -> void:
	#print(linear_velocity.length())
	if linear_velocity.length() >= 2000.0:
		linear_velocity = linear_velocity.normalized() * 20
	# Manual sprite rotation (Physics engine handles body movement)
	sprite.rotation_degrees += (linear_velocity.length() * 5) * delta
	#print(sprite.rotation_degrees)
	# Handling "Deletions" and Speed Logic
	var current_speed = linear_velocity.length()
	if current_speed <= 50.0:
		%CollisionShape2D.set_deferred("disabled", true)
		%ExplosionParticles.emitting = true
		linear_velocity = Vector2.ZERO
		await %ExplosionParticles.finished
		queue_free()

 #To handle your speed modifiers (paddle vs wall), use the body_entered signal
func _on_body_entered(body: Node) -> void:
	print("body entered")
	if body.is_in_group("paddle"):
		print("paddle hit!")
		linear_velocity *= 2.0
	if body.is_in_group("minion"):
		print("minion detected!")
		linear_velocity *= 0.99
		body.destroy()
		return
	_animate_sparks()
	linear_velocity *= 0.7


func _animate_sparks():
	particles.emitting = true
	var tween = create_tween()
	%PointLight2D.energy = 4.25
	tween.tween_property($PointLight2D, "energy", 0.0, 0.2)
