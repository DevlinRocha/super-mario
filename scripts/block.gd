class_name Block

extends StaticBody2D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)


func _on_hit() -> void:
	queue_free()
