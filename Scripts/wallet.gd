extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var player = $"../Player"
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:
		dialogue.get_dialogue("wallet")
		player.got_wallet = true
		queue_free()

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
