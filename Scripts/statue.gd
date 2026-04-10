extends Node3D

@onready var player = $"../../Player"
@onready var wallet = $"../../Wallet"
@onready var dialogue = $"../../DialogueUI"
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and player.got_wallet:
		dialogue.get_dialogue("storewallet")
		
		# change wallet pos
		wallet.position = Vector3(-105.5, 18.1, 2)
		wallet.rotation_degrees = Vector3(-11, 10, -12)

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false
