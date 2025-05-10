extends Control


@onready var label: Label = $Label


var points := 0


func _ready() -> void:
	label.text = str(points)
	display_points()


func display_points() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", position - Vector2(0, 16), 0.5)
	tween.finished.connect(func() -> void: queue_free())
