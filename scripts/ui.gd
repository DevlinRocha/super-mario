extends CanvasLayer


@onready var player: Player = $"../Player"
@onready var score: Label = %Score
@onready var coin_count: Label = %CoinCount
@onready var timer: Label = $HUD/Time/Timer


const SCORE_INCREASE = preload("res://scenes/score_increase.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.coin_collected.connect(_on_coin_collected)
	player.mushroom_collected.connect(_on_mushroom_collected)
	player.increase_score.connect(increase_score)
	decrement_timer()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_coin_collected(score_position: Vector2) -> void:
	increase_score(200, score_position)
	increase_coins(1)


func _on_mushroom_collected(score_position: Vector2) -> void:
	increase_score(1000, score_position)


func increase_score(value: int, score_position: Vector2) -> void:
	display_points(value, score_position)
	score.text = str("%06d" % (int(score.text) + value))


func increase_coins(value: int) -> void:
	coin_count.text = "x" + str("%02d" % (int(coin_count.text) + value))


func decrement_timer() -> void:
	timer.text = str(int(timer.text) - 1)
	if int(timer.text) > 0:
		get_tree().create_timer(1, false).timeout.connect(decrement_timer)
	else:
		get_tree().reload_current_scene()


func display_points(points: int, score_position: Vector2) -> void:
	var score := SCORE_INCREASE.instantiate()
	score.points = points
	score.position = score_position - Vector2(0, 24)
	add_sibling(score)
