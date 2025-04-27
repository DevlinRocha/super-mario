extends CanvasLayer


@onready var player: Player = $"../Player"
@onready var score: Label = %Score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.coin_collected.connect(_on_coin_collected)


func _on_coin_collected() -> void:
	score.text = str("%06d" % (int(score.text) + 200))
