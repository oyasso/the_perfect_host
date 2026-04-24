extends Control

@onready var background = $Background
@onready var fade = $Fade
@onready var intro_text = $IntroText
@onready var end_text = $EndText
@onready var next_button = $NextButton
@onready var voice = $Voice
@onready var select = $Select
@onready var hover = $Hover
@onready var triangle = $Triangle

var text_speed = 10.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	BgMusic.player.stream = load("res://Sounds/SFX Crowd Ambience.wav")
	BgMusic.play()
	Pause.can_pause = false
	Pause.dialogue_playing = false
	Pause.objectives = []

func show_text():
	intro_text.show()
	await animate_text(intro_text)
	#var tween : Tween = create_tween()
	#tween.tween_property(intro_text, "visible_ratio", 1.0, intro_text.text.length()/text_speed).from(0.0)
	#voice.play()
	#await tween.finished
	#voice.stop()
	await get_tree().create_timer(1.5).timeout
	intro_text.hide()
	show_end_text()

func show_end_text():
	end_text.show()
	await animate_text(end_text)
	#var tween : Tween = create_tween()
	#tween.tween_property(end_text, "visible_ratio", 1.0, end_text.text.length()/text_speed).from(0.0)
	#voice.play()
	#await tween.finished
	#voice.stop()
	next_button.show()

func animate_text(text):
	for n in text.text:
		if n not in [".", ","]:
			voice.play()
		text.visible_characters += 1
		await get_tree().create_timer(0.1).timeout
	triangle.show()

func _on_button_mouse_entered() -> void:
	hover.play()
	background.texture = load("res://Sprites/Title Hover.png")

func _on_button_mouse_exited() -> void:
	background.texture = load("res://Sprites/Title.png")

func _on_button_pressed() -> void:
	select.play()
	fade.show()
	var tween = create_tween()
	tween.tween_property(fade, "color:a", 1.0, 1.0)
	await tween.finished
	show_text()

func _on_next_button_pressed() -> void:
	select.play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
