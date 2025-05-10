class_name Block


extends StaticBody2D


signal hit


@onready var hitbox: Area2D = $Hitbox


var item_inside: Node
var items_above := []
var enemies_above := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)
	hitbox.area_entered.connect(_on_area_entered_hitbox)
	hitbox.area_exited.connect(_on_area_exited_hitbox)
	hitbox.body_entered.connect(_on_body_entered_hitbox)
	hitbox.body_exited.connect(_on_body_exited_hitbox)
	find_item(position)


func _on_hit(player: Player) -> void:
	if enemies_above:
		for enemy: Enemy in enemies_above:
			enemy.hit.emit()
			player.increase_score.emit(100, enemy.position)

	if items_above:
		for item: Item in items_above:
			item.collected.emit()
			player.coin_collected.emit()

	var up := create_tween()
	up.tween_property(self, "position", position - Vector2(0, 4), 0.1)
	await up.finished
	var down := create_tween()
	down.tween_property(self, "position", position + Vector2(0, 6), 0.1)
	await down.finished
	var reset := create_tween()
	reset.tween_property(self, "position", position - Vector2(0, 2), 0.1)
	await reset.finished

	if !item_inside: return
	item_inside.visible = true
	var item_tween := create_tween()
	item_tween.tween_property(item_inside, "position", item_inside.position - Vector2(0, 16), 0.5)
	item_inside.in_block = false
	item_inside = null


func _on_area_entered_hitbox(area: Area2D) -> void:
	if area is Item:
		items_above.append(area)


func _on_area_exited_hitbox(area: Area2D) -> void:
	items_above.erase(area)


func _on_body_entered_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.append(body)


func _on_body_exited_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.erase(body)


func find_item(coords: Vector2) -> void:
	var items := get_node("../../Items")
	for child in items.get_children():
		if child.position.is_equal_approx(coords):
			item_inside = child
			item_inside.visible = false
			item_inside.in_block = true
