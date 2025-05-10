class_name Warp


extends Area2D


signal enter


@export var destination: Vector2
@export var camera_limit_left: int
@export var camera_limit_right: int


func _ready() -> void:
	enter.connect(_on_enter)


func _on_enter(target: Node) -> void:
	target.position = destination
