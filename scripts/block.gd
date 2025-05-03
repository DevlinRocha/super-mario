class_name Block


extends StaticBody2D


signal hit


@export var item: PackedScene
@onready var hitbox: Area2D = $Hitbox


var enemies_above := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)
	hitbox.body_entered.connect(_on_body_entered_hitbox)
	hitbox.body_exited.connect(_on_body_exited_hitbox)


func _on_hit() -> void:
	if enemies_above:
		for enemy in enemies_above:
			enemy.hit.emit()

	if !item: return

	var item_instance := item.instantiate()
	add_sibling(item_instance)
	item_instance.position = position + Vector2(0, -16)


func _on_body_entered_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.append(body)

func _on_body_exited_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.erase(body)
