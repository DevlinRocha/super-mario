extends CharacterBody2D


const SPEED := 40
var in_block := false
var direction := 1


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not in_block:
		velocity += get_gravity() * delta

	if not in_block:
		velocity.x = direction * SPEED
		move_and_slide()

	if is_on_wall():
		direction *= -1


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()
		body.mushroom_collected.emit(position)
