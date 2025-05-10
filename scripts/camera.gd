extends Camera2D


var starting_position: float
var greatest_position: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_position = get_screen_center_position().x
	greatest_position = starting_position
	drag_right_margin = -0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_position := get_screen_center_position().x
	if current_position > greatest_position:
		greatest_position = current_position
		limit_left = greatest_position - starting_position
