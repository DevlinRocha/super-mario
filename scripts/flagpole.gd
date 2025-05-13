extends Area2D


@onready var bottom: Marker2D = $Bottom


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return

	body.velocity = Vector2(0, 0)
	body.handling_input = false
	var tween := create_tween()
	tween.tween_property(body, "position", bottom.global_position, 2)
