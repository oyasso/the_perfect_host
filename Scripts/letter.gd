extends Control

@onready var texture = $Pivot/TextureRect
@onready var fade = $ColorRect

func _on_button_mouse_entered() -> void:
	texture.texture = load("res://Sprites/letter_hover.png")

func _on_button_mouse_exited() -> void:
	texture.texture = load("res://Sprites/letter.png")

func _on_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	texture.hide()
	fade.color.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade, "color:a", 0.0, 1.0)
	await tween.finished
	queue_free()
