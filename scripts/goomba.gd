class_name Enemy

extends CharacterBody2D


signal hit


const SPEED := 40
var direction := -1


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hurtbox.area_entered.connect(_on_area_entered_hurtbox)
	hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED
	if direction != 0:
		animation_player.play("Moving")

	move_and_slide()
	if is_on_wall():
		direction *= -1


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		hit.emit()


func _on_hit() -> void:
	animation_player.stop()
	direction = 0
	sprite_2d.frame = 2
	hurtbox.collision_layer = 0
	hitbox.collision_layer = 0
	await get_tree().create_timer(0.5).timeout.connect(func(): queue_free())
