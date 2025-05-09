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
	if body is Player:
		_on_collected()
		body.coin_collected.emit()
