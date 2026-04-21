extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var player = $"../Player"
@onready var exclamation = $Exclamation
@onready var body_animation = $AnimationPerson
@onready var plate_animation = $AnimationPlate
@onready var scallop_animation = $AnimationScallop
@onready var plate = $dish
@onready var scallops = $Scallops_
var talked_count = 0
var talk_ready = false

func _ready():
	get_viewport().size_changed.connect(_update_spacer)
	_update_spacer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("talk") and talk_ready and not dialogue.is_talking:
		match talked_count:
			0:
				if player.got_items:
					dialogue.get_dialogue("food")
					talked_count += 1
					player.occured_interaction()
					hide_exclamation()
				else:
					dialogue.get_dialogue("nofood")
			1:
				dialogue.get_dialogue("allergy")
				talked_count += 1
			2:
				dialogue.get_dialogue("allergy2")
				talked_count += 1
			3:
				dialogue.get_dialogue("allergy3")

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()

func hide_exclamation():
	exclamation.hide()

func eat():
	plate.show()
	scallops.show()
	body_animation.stop()
	body_animation.play("eating")
	plate_animation.play("dish")
	scallop_animation.play("scallop")

func _update_spacer():
	var h = get_viewport()
