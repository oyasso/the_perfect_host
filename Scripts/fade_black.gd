extends ColorRect

@onready var fade_rect = $ColorRect

func fade_out(fade_time: int):
	self.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_time)
	await tween.finished
	self.hide()

func fade_in(fade_time: int):
	self.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, fade_time)
	await tween.finished

#func _on_button_pressed() -> void:
	#fade_out()
