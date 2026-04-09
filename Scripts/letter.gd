extends Control

@onready var texture = $TextureRect

func _on_button_mouse_entered() -> void:
	texture.texture = load("res://Sprites/letter_hover.png")

func _on_button_mouse_exited() -> void:
	texture.texture = load("res://Sprites/letter.png")

func _on_button_pressed() -> void:
	queue_free()
