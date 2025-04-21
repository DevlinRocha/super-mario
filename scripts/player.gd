extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	handle_movement(delta)

	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider is Block:
			collider.hit.emit()


func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if !direction:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity.x = direction * SPEED
	animation_player.play("Moving")
	if direction == 1:
		sprite_2d.flip_h = 0
	elif direction == -1:
		sprite_2d.flip_h = 1

	if velocity == Vector2(0, 0):
		animation_player.stop()

	move_and_slide()
