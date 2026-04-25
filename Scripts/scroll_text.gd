extends RichTextLabel

@export var scroll_speed := 60.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if position.y > -4100:
		position.y -= scroll_speed * _delta
	else:
		await get_tree().create_timer(5.0).timeout
