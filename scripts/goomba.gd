class_name Enemy

extends CharacterBody2D


signal hit


const SPEED := 40
var direction := -1
var move := false


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox
@onready var detection: Area2D = $Detection
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hurtbox.area_entered.connect(_on_area_entered_hurtbox)
	detection.body_entered.connect(func(body: Node2D) -> void: move = true)
	
	hit.connect(_on_hit)
	animation_player.play("Moving")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED * direction

	if move:
		move_and_slide()

	if is_on_wall():
		direction *= -1


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		animation_player.stop()
		direction = 0
		sprite_2d.frame = 2
		hurtbox.collision_layer = 0
		hurtbox.collision_mask = 0
		hitbox.collision_layer = 0
		await get_tree().create_timer(0.5).timeout.connect(func() -> void: queue_free())



func _on_hit() -> void:
	animation_player.stop()
	hurtbox.collision_layer = 0
	hurtbox.collision_mask = 0
	hitbox.collision_layer = 0
	collision_mask = 0
	sprite_2d.flip_v = true
	velocity.y = -160
