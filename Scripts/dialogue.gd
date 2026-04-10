extends Node

var debug = false
var debug_line = "where"

# Path to JSON
var json_file = "res://Dialogue/perfect_host_dialogue7.json"
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
var change_pos_conflict = false

# references to nodes
@onready var dialogue_ui : Control = $"."
@onready var speaker_label : Label = $DialogueBox/SpeakerLabel
@onready var text_label : RichTextLabel = $DialogueBox/DialogueText
@onready var speaker_sprite : TextureRect = $TextureCharacter
@onready var choice_box : VBoxContainer = $"DialogueBox/ChoiceBox"
@onready var option1 : Button = $DialogueBox/ChoiceBox/Option1
@onready var option2 : Button = $DialogueBox/ChoiceBox/Option2
@onready var next_button : Button = $DialogueBox/NextButton
@onready var end_button : Button = $DialogueBox/End
@onready var player : CharacterBody3D = $"../Player"
@onready var letter = $"../Letter"
@onready var change_position_script = $"../change_positions"

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if debug:
		get_dialogue(debug_line)

func get_dialogue(id: String):
	is_talking = true
	dialogue_ui.show()
	end_button.hide()
	if not debug:
q		player.can_move = false

	# change the speaker label, dialogue text and speaker sprite
	speaker_label.text = json_dict[id]["character"]
	text_label.text = json_dict[id]["text"]
	
	# animate the text
	var tween : Tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, text_label.text.length()/text_speed).from(0.0)
	tween.connect("finished", on_tween_finished.bind(id))

	speaker_sprite.texture = load("res://Sprites/" + json_dict[id]["sprite"] + "_Pixel_Sprite.png")

	if id == "drinks7":
		show_letter = true
		change_pos_middle = true
	
	if id == "goingon":
		change_pos_conflict = true

# if first option is picked get its dialogue
func _on_option_1_pressed() -> void:
	hide_continue_buttons()
	get_dialogue(next_dialogue[0])

# if second option is picked get its dialogue
func _on_option_2_pressed() -> void:
	hide_continue_buttons()
	get_dialogue(next_dialogue[1])

# if next button is clicked get next dialogue
func _on_next_button_pressed() -> void:
	hide_continue_buttons()
	get_dialogue(next_dialogue)

func _on_end_pressed() -> void:
	dialogue_ui.hide()
	is_talking = false
	if !debug:
		player.can_move = true
		
	# show the letter
	if show_letter:
		letter.show()
		show_letter = false
	
	if change_pos_middle:
		change_position_script.change_middle()
		change_pos_middle = false

	if change_pos_conflict:
		change_position_script.change_conflict()
		change_pos_conflict = false
	
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

func hide_continue_buttons():
	choice_box.hide()
	next_button.hide()
