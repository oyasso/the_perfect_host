extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var player = $"../Player"
var talked_count = 0
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:
		match talked_count:
			0:
				if player.got_food:
					dialogue.get_dialogue("food")
					talked_count += 1
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
