class_name Block


extends StaticBody2D


signal hit


@onready var hitbox: Area2D = $Hitbox


var items: TileMapLayer
var enemies_above := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)
	hitbox.body_entered.connect(_on_body_entered_hitbox)
	hitbox.body_exited.connect(_on_body_exited_hitbox)
	items = get_node("../../Items")


func _on_hit() -> void:
	if enemies_above:
		for enemy in enemies_above:
			enemy.hit.emit()

	var grid_position := items.local_to_map(position)
	var source_id := items.get_cell_source_id(grid_position)
	var alt_id = items.get_cell_alternative_tile(grid_position)
	items.set_cell(grid_position, -1)

	var up := create_tween()
	up.tween_property(self, "position", position - Vector2(0, 4), 0.1)
	await up.finished
	var down := create_tween()
	down.tween_property(self, "position", position + Vector2(0, 6), 0.1)
	await down.finished
	var reset := create_tween()
	reset.tween_property(self, "position", position - Vector2(0, 2), 0.1)
	await reset.finished

	items.set_cell(grid_position + Vector2i(0, -1), source_id, Vector2i(0, 0), alt_id)


func _on_body_entered_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.append(body)


func _on_body_exited_hitbox(body: Node2D) -> void:
	if body is Enemy:
		enemies_above.erase(body)
