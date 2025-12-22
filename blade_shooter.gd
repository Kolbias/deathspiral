extends Node2D

@export var player_scene: PackedScene
#@export var spiral_amount: int = 25

var mouse_pos: Vector2

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

	if Input.is_action_just_pressed("shoot"):
		if player_scene:
			if GameGlobals.ammo >= 0:
				GameGlobals.ammo -= 1
				var new_scene = player_scene.instantiate()
				new_scene.launch_dir = mouse_pos - global_position
				get_parent().add_child(new_scene)
				new_scene.global_position = global_position
			else:
				print("Out of Ammo!")

	
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action("ui_accept"):
		#if player_scene:
			#var new_scene = player_scene.instantiate()
			#new_scene.launch_dir = position
			#get_parent().add_child(new_scene)
			#new_scene.global_position = global_position
