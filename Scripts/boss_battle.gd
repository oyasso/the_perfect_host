extends Control

@onready var speaker_label : Label = $DialogueBox/SpeakerLabel
@onready var text_label : RichTextLabel = $DialogueBox/DialogueText
@onready var buttons : Control = $Buttons
@onready var attack_button : Button = $Buttons/AttackButton
@onready var defend_button : Button = $Buttons/DefendButton
@onready var next_button : Button = $DialogueBox/NextButton

var text_speed = 30.0

var turn_counter = 0

var attack_text = "Kiyoshi tries to muster all of his courage, but he cannot fight back."
var defend_text = ["Kiyoshi cannot look at them.", "Mom, Dad, please! I'm sorry! It was just a mistake!",
"I can do better! I can better!", "Please, give me another chance!", "Please, I love you! Don't do this."]
var boss_text = ["LOOK AT ME WHEN I SPEAK TO YOU, CHILD!", "YOU'VE MADE TOO MANY!",
"YOU HAVE BEEN NOTHING BUT A DISAPPOINTMENT!", "ALL YOU DO IS FAIL!", "WE'RE DONE WITH YOU!"]


func show_player_attack_dialogue():
	buttons.hide()
	text_label.text = "Kiyoshi tries to muster all of his courage, but he cannot fight back."

	# animate the text
	var tween : Tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, text_label.text.length()/text_speed).from(0.0)
	tween.connect("finished", on_tween_boss_finished.bind())

func show_player_defend_dialogue(text: String):
	print(turn_counter)
	buttons.hide()
	next_button.show()

	if turn_counter <= 1:
		speaker_label.hide()
	else:
		speaker_label.show()
	speaker_label.text = "Kiyoshi"
	text_label.text = text

	# animate the text
	var tween : Tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, text_label.text.length()/text_speed).from(0.0)
	tween.connect("finished", on_tween_player_defend_finished.bind())

func on_tween_player_defend_finished():
	next_button.show()

func show_boss_dialogue(text: String):
	print(turn_counter)
	speaker_label.show()
	speaker_label.text = "Mother+Father"
	text_label.text = text

	# animate the text
	var tween : Tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, text_label.text.length()/text_speed).from(0.0)
	tween.connect("finished", on_tween_boss_finished.bind())

func on_tween_boss_finished():
	buttons.show()
	next_button.hide()

func _on_next_button_pressed() -> void:
	show_boss_dialogue(boss_text[turn_counter])
	turn_counter += 1

func _on_attack_button_pressed() -> void:
	show_player_attack_dialogue()

func _on_defend_button_pressed() -> void:
	show_player_defend_dialogue(defend_text[turn_counter])
