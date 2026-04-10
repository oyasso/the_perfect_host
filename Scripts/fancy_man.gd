extends MeshInstance3D

@onready var player = $"../Player"
@onready var dialogue = $"../DialogueUI"
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("talk") and talk_ready and not dialogue.is_talking:		
		if player.got_drinks:
			dialogue.get_dialogue("beverage")
			player.occured_interaction()
		else:
			dialogue.get_dialogue("nobeverage")
			

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
