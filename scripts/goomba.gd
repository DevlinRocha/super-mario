class_name Enemy

extends CharacterBody2D


signal hit


const SPEED := 40
var direction := -1


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED
	animation_player.play("Moving")

	move_and_slide()

	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider is Player:
			collider.hit.emit()


func _on_hit() -> void:
	queue_free()
