extends Control

@onready var background = $Background
@onready var fade = $Fade
@onready var intro_text = $IntroText
@onready var end_text = $EndText
@onready var next_button = $NextButton

var text_speed = 10.0

func show_text():
	intro_text.show()
	var tween : Tween = create_tween()
	tween.tween_property(intro_text, "visible_ratio", 1.0, intro_text.text.length()/text_speed).from(0.0)
	await tween.finished
	await get_tree().create_timer(1.5).timeout
	intro_text.hide()
	show_end_text()

func show_end_text():
	end_text.show()
	var tween : Tween = create_tween()
	tween.tween_property(end_text, "visible_ratio", 1.0, end_text.text.length()/text_speed).from(0.0)
	await tween.finished
	next_button.show()

func _on_button_mouse_entered() -> void:
	background.texture = load("res://Sprites/Title Hover.png")

func _on_button_mouse_exited() -> void:
	background.texture = load("res://Sprites/Title.png")

func _on_button_pressed() -> void:
	fade.show()
	var tween = create_tween()
	tween.tween_property(fade, "color:a", 1.0, 1.0)
	await tween.finished
	show_text()

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
