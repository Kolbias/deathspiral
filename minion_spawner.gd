extends Node2D

@export var minion_scene: PackedScene
@export var min_time := 0.5
@export var max_time := 2.0

@onready var timer: Timer = %Timer

func _ready() -> void:
	timer.wait_time = randf_range(min_time, max_time)


func _on_timer_timeout() -> void:
	var i = minion_scene.instantiate()
	add_child(i)
