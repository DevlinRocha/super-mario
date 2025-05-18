extends CharacterBody2D


signal hit


const SPEED := 160
var direction := 0


@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	hurtbox.area_entered.connect(_on_area_entered_hurtbox)
	hurtbox.body_entered.connect(_on_body_entered_hurtbox)
	hit.connect(_on_hit)
	hitbox.collision_layer = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED * direction

	if direction != 0:
		move_and_slide()

	if direction != 0 and is_on_wall():
		direction *= -1


func _on_area_entered_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		if direction == 0:
			if area.get_parent().sprite_2d.flip_h:
				direction = -1
			else:
				direction = 1
			hitbox.collision_layer = 2
		else:
			direction = 0
			hitbox.collision_layer = 0


func _on_body_entered_hurtbox(body: Node2D) -> void:
	if body is Player and body.is_on_floor() and direction == 0:
		if body.sprite_2d.flip_h:
			direction = -1
		else:
			direction = 1
		hitbox.collision_layer = 2


func _on_hit() -> void:
	hurtbox.collision_layer = 0
	hurtbox.collision_mask = 0
	hitbox.collision_layer = 0
	collision_mask = 0
	velocity.y = -160
