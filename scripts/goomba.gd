class_name Enemy

extends CharacterBody2D


signal hit


const SPEED := 40
var direction := -1


func _ready() -> void:
	hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hit() -> void:
	queue_free()
