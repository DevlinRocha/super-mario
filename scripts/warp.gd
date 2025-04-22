class_name Warp


extends Area2D


signal enter


@export var destination: Vector2


func _ready() -> void:
	enter.connect(_on_enter)


func _on_enter(target) -> void:
	target.position = destination
