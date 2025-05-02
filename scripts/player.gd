class_name Player


extends CharacterBody2D


const SPEED := 160.0
const JUMP_VELOCITY := -352.0
var jumping := false


signal increase_score
signal coin_collected

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d_up: RayCast2D = $RayCast2DUp
@onready var ray_cast_2d_down: RayCast2D = $RayCast2DDown
@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D


func _ready() -> void:
	hurtbox.area_entered.connect(_on_area_entered_hurtbox)
	hitbox.area_entered.connect(_on_area_entered_hitbox)


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
	else:
		jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.stop()
		sprite_2d.frame = 4
		jumping = true

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if !direction:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity.x = direction * SPEED
	# Handle animations.
	if not jumping: animation_player.play("Moving")
	if velocity == Vector2(0, 0):
		animation_player.stop()
		sprite_2d.frame = 0

	if direction == 1:
		sprite_2d.flip_h = 0
	elif direction == -1:
		sprite_2d.flip_h = 1
		if position.x <= camera_2d.limit_left + 10:
			velocity.x = 0


	if Input.is_action_just_pressed("down") and is_on_floor() and ray_cast_2d_down.is_colliding():
		var collider = ray_cast_2d_down.get_collider()
		if collider is Warp:
			collider.enter.emit(self)

	move_and_slide()


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		get_tree().reload_current_scene()


func _on_area_entered_hitbox(area: Area2D) -> void:
	if area.is_in_group("Hurtbox") and not is_on_floor():
		velocity.y = JUMP_VELOCITY / 2
		increase_score.emit(100)
