extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var body_animation = $AnimationPerson
var talk_ready = false
var first_talk = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:		
		if first_talk:
			dialogue.get_dialogue("outfit")
			first_talk = false
		else:
			dialogue.get_dialogue("candles")

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
