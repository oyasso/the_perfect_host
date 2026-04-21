extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var uncle = $"../Uncle"
@onready var exclamation = $Exclamation
@onready var body_animation = $AnimationPerson
@onready var invis_wall = $"../InvisibleWall"
var talked_count = 0
var talk_ready = false

func _process(_delta: float) -> void:
	if Input.is_action_just_released("talk") and talk_ready and not dialogue.is_talking:
		match talked_count:
			0:
				dialogue.get_dialogue("where")
				talked_count += 1
				uncle.show_exclamation()
				hide_exclamation()
				invis_wall.queue_free()

			1:
				dialogue.get_dialogue("cater")
				talked_count += 1
	
	#if dialogue.is_talking and dialogue.speaker_label.text == "Mother":
		#talk_animation.play("Armature TorsoAction")

		#if uncle_script.drinks_counter >= 3:
			#dialogue.get_dialogue("goingon")

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()

func hide_exclamation():
	exclamation.hide()
