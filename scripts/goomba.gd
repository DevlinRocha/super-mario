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


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED
	if direction != 0:
		animation_player.play("Moving")

	move_and_slide()


func _on_area_entered_hurtbox(area: Area2D) -> void:
	animation_player.stop()
	direction = 0
	sprite_2d.frame = 2
	hit.emit()
	await get_tree().create_timer(0.25).timeout.connect(func(): queue_free())
