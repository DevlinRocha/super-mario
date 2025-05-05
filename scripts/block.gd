class_name Block


extends StaticBody2D


signal hit


@onready var hitbox: Area2D = $Hitbox


var item
var enemies_above := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)
	hitbox.body_entered.connect(_on_body_entered_hitbox)
	hitbox.body_exited.connect(_on_body_exited_hitbox)
	find_item(position)


func _on_hit() -> void:
	if enemies_above:
		for enemy in enemies_above:
			enemy.hit.emit()

	var up := create_tween()
	up.tween_property(self, "position", position - Vector2(0, 4), 0.1)
	await up.finished
	var down := create_tween()
	down.tween_property(self, "position", position + Vector2(0, 6), 0.1)
	await down.finished
	var reset := create_tween()
	reset.tween_property(self, "position", position - Vector2(0, 2), 0.1)
	await reset.finished

	if !item: return
	item.visible = true
	var item_tween := create_tween()
	item_tween.tween_property(item, "position", item.position - Vector2(0, 16), 0.5)
	item = null


func _on_body_entered_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.append(body)


func _on_body_exited_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.erase(body)


func find_item(coords: Vector2) -> void:
	var items = get_node("../../Items")
	for child in items.get_children():
		if child.position.is_equal_approx(coords):
			item = child
			item.visible = false
