class_name Block


extends StaticBody2D


signal hit


@export var item: PackedScene
@onready var label: Label = $ColorRect/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)


func _on_hit() -> void:
	if !item: return

	var item_instance := item.instantiate()
	add_sibling(item_instance)
	item_instance.position = position + Vector2(0, -16)
