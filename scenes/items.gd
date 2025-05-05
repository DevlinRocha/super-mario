extends TileMapLayer


@onready var player: Player = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(0.1).timeout.connect(func():
		for child in get_children():
			child.collected.connect(_on_item_collected.bind(child.name))
		)


func _on_item_collected(item: String) -> void:
	match item:
		"Coin":
			player.coin_collected.emit()
