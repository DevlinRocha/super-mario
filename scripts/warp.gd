class_name Warp


extends Area2D


signal enter


func _ready() -> void:
	enter.connect(_on_enter)


func _on_enter() -> void:
	print("warp")
