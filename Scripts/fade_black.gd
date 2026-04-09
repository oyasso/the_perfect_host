extends CanvasLayer

@onready var fade_rect = $ColorRect

# Called when the node enters the scene tree for the first time.
func fade_out():
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.0)
	await tween.finished
	self.hide()
