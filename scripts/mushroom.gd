extends CharacterBody2D


const SPEED := 40
var in_block := false
var direction := 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not in_block:
		velocity += get_gravity() * delta

	if not in_block:
		velocity.x = direction * SPEED
		move_and_slide()
