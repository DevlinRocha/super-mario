extends CanvasLayer


@onready var player: Player = $"../Player"
@onready var score: Label = %Score
@onready var coin_count: Label = %CoinCount
@onready var timer: Label = $HUD/Time/Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.coin_collected.connect(_on_coin_collected)
	player.increase_score.connect(increase_score)
	decrement_timer()

func _on_coin_collected() -> void:
	increase_score(200)
	increase_coins(1)


func increase_score(value: int) -> void:
	score.text = str("%06d" % (int(score.text) + value))


func increase_coins(value: int) -> void:
	coin_count.text = "x" + str("%02d" % (int(coin_count.text) + value))


func decrement_timer() -> void:
	timer.text = str(int(timer.text) - 1)
	if int(timer.text) > 0:
		get_tree().create_timer(1).timeout.connect(decrement_timer)
