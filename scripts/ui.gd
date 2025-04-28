extends CanvasLayer


@onready var player: Player = $"../Player"
@onready var score: Label = %Score
@onready var coin_count: Label = %CoinCount


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.coin_collected.connect(_on_coin_collected)
	var goombas = get_parent().find_children("Goomba*")
	for goomba in goombas:
		goomba.hit.connect(_on_goomba_hit)


func _on_coin_collected() -> void:
	increase_score(200)
	coin_count.text = "x" + str("%02d" % (int(coin_count.text) + 1))


func _on_goomba_hit() -> void:
	increase_score(100)


func increase_score(value: int) -> void:
	score.text = str("%06d" % (int(score.text) + value))
