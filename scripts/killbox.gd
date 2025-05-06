extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	if body is Player:
		get_tree().reload_current_scene()
