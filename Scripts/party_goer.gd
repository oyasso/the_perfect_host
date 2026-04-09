extends Node3D

@onready var dialogue = $"../DialogueUI"
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:		
		var random_line = ["lost", "leave"].pick_random()
		dialogue.get_dialogue(random_line)

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true
	print("area entered")

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
