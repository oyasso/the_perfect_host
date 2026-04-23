extends Node

var fast_dialogue = true
var debug = false
var debug_line = "where"

# Path to JSON
var json_file = "res://Dialogue/perfect_host_dialogue12.json"
var json_text = FileAccess.get_file_as_string(json_file)
var json_dict = JSON.parse_string(json_text)[0]

# bool for showing option box or not
var next_is_options = false
# next dialogue
var next_dialogue = null

var text_speed = 30.0
var text_animated = false
var is_talking = false

var show_letter = false # bool for showing the letter
var change_pos_middle = false
#var change_conflict_scene = false
var one_interaction = false
var two_interactions = false
var three_interactions = false

var start_boss = false
var end_game = false

var fancy_man_drink = false
var fancy_lady_eat = false

var move_uncle = false
var mother_stop_talking = false
var uncle_trips = false
var uncle_balcony = false

# references to nodes
@onready var dialogue_ui : Control = $"."
@onready var speaker_label : Label = $DialogueBox/SpeakerLabel
@onready var text_label : RichTextLabel = $DialogueBox/DialogueText
@onready var speaker_sprite : TextureRect = $TextureCharacter
@onready var choice_box : VBoxContainer = $DialogueBox/ChoiceBox
@onready var option1 : Button = $DialogueBox/ChoiceBox/Option1
@onready var option2 : Button = $DialogueBox/ChoiceBox/Option2
@onready var next_button : Button = $DialogueBox/NextButton
@onready var end_button : Button = $DialogueBox/End
@onready var player : CharacterBody3D = $"../Player"
@onready var letter = $"../Letter"
@onready var change_position_script = $"../change_positions"
@onready var conflict_scene = $".."
@onready var end_scene = $".."
@onready var fade = $"../FadeOut"
@onready var uncle = $"../Uncle"
@onready var mother = $"../Mother"
@onready var fancy_man = $"../FancyMan"
@onready var fancy_lady = $"../FancyLady"
@onready var butler = $"../Butler"
@onready var wallet = $"../Wallet"
@onready var bgmusic = $"../BGMusic"
@onready var voice = $Voice
@onready var select = $Select
@onready var hover = $Hover
@onready var close = $Close
@onready var give2 = $Give2

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if debug:
		get_dialogue(debug_line)

func get_dialogue(id: String):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	is_talking = true
	dialogue_ui.show()
	Pause.dialogue_playing = true
	end_button.hide()
	if not debug:
		player.can_move = false

	# change the speaker label, dialogue text and speaker sprite
	speaker_label.text = json_dict[id]["character"]
	text_label.text = json_dict[id]["text"]
	
		# animate the speaker
	if id != "goingon":
		match json_dict[id]["character"]:
			"Kiyoshi":
				voice.stream = load("res://Sounds/SFX Vox Kiyoshi Extended.wav")
			"Mother":
				mother.body_animation.play("talk")
				voice.stream = load("res://Sounds/SFX Vox Mother Extended.wav")
			"Mother+Father":
				voice.stream = load("res://Sounds/DOP_SFX_Vox_Parents_Extended_W_.wav")
			"Uncle":
				if id not in ["third", "fourth", "fifth", "sixth", "fake1", "fake3", "fake5", "fake7", "fake9"]:
					uncle.body_animation.play("talk")
					voice.stream = load("res://Sounds/SFX Vox Uncle Extended.wav")
				else:
					uncle.body_animation.play("drunk")
					voice.stream = load("res://Sounds/SFX Vox Uncle Alt Extended.wav")
			"Fancy Man":
				if not fancy_man_drink and id != "notalk":
					fancy_man.body_animation.play("talk")
				voice.stream = load("res://Sounds/SFX Vox Generic 2 Extended.wav")
			"Fancy Lady":
				if not fancy_lady_eat and id not in ["allergy", "allergy1", "allergy2"]:
					fancy_lady.body_animation.play("talk")
				if id in ["allergy3", "fake14"]:
					fancy_lady.chocking()
				voice.stream = load("res://Sounds/DOP_SFX_Vox_Generic_Combined_Extended_W_.wav")
			"Butler":
				butler.body_animation.play("talk")
				voice.stream = load("res://Sounds/SFX Vox Generic Extended.wav")
			"Father":
				voice.stream = load("res://Sounds/SFX Vox Father Extended.wav")
			"Party Goer":
				voice.stream = load("res://Sounds/SFX Vox Generic 2 Extended.wav")
			"Fama":
				voice.stream = load("res://Sounds/SFX Vox Generic 2 Extended.wav")
	
	# animate the text
	var tween : Tween = create_tween()
	if not fast_dialogue:
		tween.tween_property(text_label, "visible_ratio", 1.0, text_label.text.length()/text_speed).from(0.0)
		voice.play()
	else:
		tween.tween_property(text_label, "visible_ratio", 1.0, 0)
	tween.connect("finished", on_tween_finished.bind(id))

	if json_dict[id]["sprite"] == "Fama":
		#speaker_sprite.position = Vector2(377, 801)
		speaker_sprite.offset_left = -583
		speaker_sprite.offset_top = -281
		speaker_sprite.offset_right = -283
		speaker_sprite.offset_bottom = 19
	else:
		#speaker_sprite.position = Vector2(454, 783)
		speaker_sprite.offset_left = -508
		speaker_sprite.offset_top = -300
		speaker_sprite.offset_right = -208
		speaker_sprite.offset_bottom = 0

	speaker_sprite.texture = load("res://Sprites/" + json_dict[id]["sprite"] + "_Pixel_Sprite.png")

	if id == "drinks7":
		show_letter = true
		change_pos_middle = true
	
	#if id == "goingon":
		#change_conflict_scene = true
	
	if id == "fake23":
		start_boss = true
	
	if id == "afterfight2":
		end_game = true
	
	if id == "charity8" or id == "question4":
		fancy_man_drink = true

	if id == "food2":
		fancy_lady_eat = true

	if id == "third":
		uncle.hide_exclamation()
		wallet.show()
		wallet.show_exclamation()
		uncle.body_animation.play("drunk")
	
	if id == "storewallet" and !uncle_balcony:
		uncle.show_exclamation()
	
	if id == "sixth" and !uncle_balcony:
		move_uncle = true
		uncle.hide_exclamation()
	
	if id in ["ready5", "fix4", "defend2", "cater", "goingon"]:
		mother_stop_talking = true
	
	if id == "fake18":
		uncle_trips = true
		uncle.fall()

# if first option is picked get its dialogue
func _on_option_1_pressed() -> void:
	select.play()
	hide_continue_buttons()
	get_dialogue(next_dialogue[0])

# if second option is picked get its dialogue
func _on_option_2_pressed() -> void:
	select.play()
	hide_continue_buttons()
	get_dialogue(next_dialogue[1])

# if next button is clicked get next dialogue
func _on_next_button_pressed() -> void:
	if next_button.text == "Hand him the drink.":
		give2.play()
	else:
		select.play()
	hide_continue_buttons()
	get_dialogue(next_dialogue)

func _on_end_pressed() -> void:
	close.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	dialogue_ui.hide()
	Pause.dialogue_playing = false
	is_talking = false
	if !debug:
		player.can_move = true
		
	# show the letter
	if show_letter:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		letter.show()
		show_letter = false
	
	if change_pos_middle:
		change_position_script.change_middle()
		change_pos_middle = false

	#if change_conflict_scene:
		#get_tree().change_scene_to_file("res://Scenes/conflict.tscn")
		#change_conflict_scene = false
	
	if player.interactions == 1 and not one_interaction and !uncle_balcony:
		uncle.show_exclamation()
		one_interaction = true
	
	if player.interactions == 2 and not two_interactions:
		get_dialogue("goingon")
		two_interactions = true
		BgMusic.player.stream = load("res://Sounds/Waltz Phase 2 V2.mp3")
		BgMusic.player.play()
	
	if player.interactions == 3 and not three_interactions and move_uncle:
		fade.show()
		fade.fade_in(1.0)
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/conflict.tscn")
		three_interactions = true
	
	if fancy_man_drink:
		fancy_man.drink()
		fancy_man_drink = false
	
	if fancy_lady_eat:
		fancy_lady.eat()
		fancy_lady_eat = false
	
	if start_boss:
		conflict_scene.end_conflict_scene()
		start_boss = false
	
	if end_game:
		end_scene.end_game()
	
	if move_uncle:
		change_position_script.change_uncle()
		move_uncle = false
		uncle_balcony = true
	
	if mother_stop_talking:
		mother.body_animation.play("idle")

func on_tween_finished(id):
	# if the dialogue contains options show its UI
	if "options" in json_dict[id]:
		if typeof(json_dict[id]["options"]) == TYPE_ARRAY:
			choice_box.show()
			next_button.hide()
			option1.text = json_dict[id]["options"][0]
			option2.text = json_dict[id]["options"][1]
		else:
			next_button.text = json_dict[id]["options"]
			choice_box.hide()
			next_button.show()
	else:
		choice_box.hide()
		next_button.text = "Next"
		next_button.show()
		
	# check if end of dialogue
	if "go to" in json_dict[id]:
		next_dialogue = json_dict[id]["go to"]
	else:
		end_button.show()
		next_button.hide()
	
	voice.stop()
	
	## stop NPC talking animation
	#match json_dict[id]["character"]:
		#"Mother":
			#mother.body_animation.play("idle")
		#"Uncle":
			#uncle.body_animation.stop()
		#"Fancy Man":
			#if not fancy_man_drink:
				#fancy_man.body_animation.stop()
		#"Fancy Lady":
			#if not fancy_lady_eat:
				#fancy_lady.body_animation.stop()
		#"Butler":
			#butler.body_animation.stop()

func hide_continue_buttons():
	choice_box.hide()
	next_button.hide()

func _on_button_mouse_entered() -> void:
	hover.play()
