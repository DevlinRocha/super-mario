extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d_up: RayCast2D = $RayCast2DUp
@onready var ray_cast_2d_down: RayCast2D = $RayCast2DDown
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	handle_movement(delta)

	if ray_cast_2d_up.is_colliding():
		var collider = ray_cast_2d_up.get_collider()
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
	# Handle animations.
	animation_player.play("Moving")
	if velocity == Vector2(0, 0):
		animation_player.stop()

	if direction == 1:
		sprite_2d.flip_h = 0
	elif direction == -1:
		sprite_2d.flip_h = 1

	if Input.is_action_just_pressed("down"):
		if ray_cast_2d_down.is_colliding():
			var collider = ray_cast_2d_down.get_collider()
			print(collider.get_class())
			if collider is Warp:
				collider.enter.emit()

	move_and_slide()
