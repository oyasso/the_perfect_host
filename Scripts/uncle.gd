extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var mother = $"../Mother"
@onready var player = $"../Player"
var first_talk = false
var talk_ready = false
var drinks_counter = 0
var tray_talk = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:
		if not first_talk:
			match drinks_counter:
				0:
					if tray_talk == false:
						if player.got_tray:
							dialogue.get_dialogue("tray")
							tray_talk = true
						elif not player.got_tray:
							dialogue.get_dialogue("notray")

					else:
						if player.got_drinks:
							dialogue.get_dialogue("drinks")
							drinks_counter += 1
						else:
							dialogue.get_dialogue("nodrinks")
				1:
					dialogue.get_dialogue("alcohol")
					drinks_counter += 1
				2:
					dialogue.get_dialogue("second")
					drinks_counter += 1
				3:
					dialogue.get_dialogue("third")
					drinks_counter += 1
				4:
					dialogue.get_dialogue("fourth")
					drinks_counter += 1
				[5, ..]:
					dialogue.get_dialogue("fifth")

		if mother.talked_count > 0 and first_talk:
			dialogue.get_dialogue("hair")
			first_talk = false

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
