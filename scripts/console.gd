extends LineEdit


func _ready() -> void:
	text_changed.connect(_on_text_changed)
	text_submitted.connect(_on_text_submitted)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("console"):
		var paused := !visible
		get_tree().paused = paused
		visible = paused
		if visible:
			grab_focus()
		else:
			release_focus()


func _on_text_changed(new_text: String) -> void:
	if new_text.contains("`"):
		var cached_caret_column := caret_column
		text = text.replace("`", "")
		caret_column = cached_caret_column


func _on_text_submitted(new_text: String) -> void:
	text = ""
	grab_focus()
