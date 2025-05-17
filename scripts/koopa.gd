extends Enemy


const SHELL = preload("res://scenes/shell.tscn")


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		var shell := SHELL.instantiate()
		shell.position = position
		add_sibling(shell)
		queue_free()
