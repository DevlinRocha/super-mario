extends Enemy


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		animation_player.stop()
		direction = 0
		hurtbox.collision_layer = 0
		hurtbox.collision_mask = 0
		hitbox.collision_layer = 0
		await get_tree().create_timer(0.5, false).timeout.connect(func() -> void: queue_free())
