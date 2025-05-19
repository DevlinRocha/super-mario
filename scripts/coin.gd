class_name Item


extends Area2D


signal collected


var in_block := false


func _ready() -> void:
	collected.connect(_on_collected)
	body_entered.connect(_on_body_entered)


func _on_collected() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.handling_input:
		_on_collected()
		body.coin_collected.emit()


func collect_from_block(player: Node2D) -> void:
	visible = true
	var up := create_tween()
	up.tween_property(self, "position", position - Vector2(0, 64), 0.25)
	await up.finished
	var down := create_tween()
	down.tween_property(self, "position", position + Vector2(0, 40), 0.25)
	await down.finished
	_on_collected()
	player.coin_collected.emit(position + Vector2(0, 16))
