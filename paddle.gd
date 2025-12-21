extends Node2D

var pos_y = position.y
var pos_x = position.x
enum Side {TOP, BOTTOM, LEFT, RIGHT}

@export var side = Side.TOP

@onready var paddle_board: CharacterBody2D = %PaddleBoard

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("hit"):
		match side:
			Side.TOP:
				var tween = create_tween()
				tween.tween_property(paddle_board, "position", Vector2(0.0, 50.0), 0.1)
				tween.tween_interval(0.1)
				tween.tween_property(paddle_board, "position", Vector2(0.0, 0.0), 0.1)

			Side.BOTTOM:
				var tween = create_tween()
				tween.tween_property(paddle_board, "position", Vector2(0.0, -50.0), 0.1)
				tween.tween_interval(0.1)
				tween.tween_property(paddle_board, "position", Vector2(0.0, 0.0), 0.1)
				
			Side.LEFT:
				var tween = create_tween()
				tween.tween_property(paddle_board, "position", Vector2(0.0, -50.0), 0.1)
				tween.tween_interval(0.1)
				tween.tween_property(paddle_board, "position", Vector2(0.0, 0.0), 0.2)
				
			Side.RIGHT:
				var tween = create_tween()
				tween.tween_property(paddle_board, "position", Vector2(0.0, 50.0), 0.1)
				tween.tween_interval(0.1)
				tween.tween_property(paddle_board, "position", Vector2(0.0, 0.0), 0.1)
		#paddle_board.position = position
		#paddle_board.position = position
		#position.x = pos_x
	paddle_board.move_and_slide()
