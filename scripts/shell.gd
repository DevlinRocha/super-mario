extends CharacterBody2D


signal hit


const SPEED := 160
var direction := 0


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered_area_2d)
	hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED * direction

	if direction != 0:
		move_and_slide()

	if direction != 0 and is_on_wall():
		direction *= -1


func _on_body_entered_area_2d(body: Node2D) -> void:
	if body is Player:
		if direction == 0:
			if body.sprite_2d.flip_h:
				direction = -1
			else:
				direction = 1
		else:
			body.hit.emit()


func _on_hit() -> void:
	collision_mask = 0
	velocity.y = -160
