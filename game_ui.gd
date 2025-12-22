extends CanvasLayer

@onready var time_amount: Label = %TimeAmount
@onready var score_amount: Label = %ScoreAmount
@onready var ammo_amount: Label = %AmmoAmount

func _ready() -> void:
	GameGlobals.connect("timer_countdown", _on_timer_countdown)
	GameGlobals.connect("enemy_killed", _on_enemy_killed)
	
	time_amount.text = str(GameGlobals.time_amount)

func _process(delta: float) -> void:
	ammo_amount.text = str(GameGlobals.ammo)

func _on_timer_countdown():
	GameGlobals.time_amount -= 1
	time_amount.text = str(GameGlobals.time_amount)
	if GameGlobals.time_amount <= 0:
		%GameOverLabel.show()
		get_tree().paused = true

func _on_enemy_killed():
	GameGlobals.score_amount += 1
	score_amount.text = str(GameGlobals.score_amount)
