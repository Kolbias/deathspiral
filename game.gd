extends Node2D


func _on_game_timer_timeout() -> void:
	GameGlobals.emit_signal("timer_countdown")
