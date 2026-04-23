extends Node3D

@onready var player = $"../Player"
@onready var uncle = $"../Uncle"
@onready var wallet = $"../WalletHidden"
@onready var dialogue = $"../DialogueUI"
@onready var exclamation = $Exclamation
var talk_ready = false
var objective_name = "Hide wallet"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("talk") and talk_ready and player.got_wallet:
		dialogue.get_dialogue("storewallet")
		
		# change wallet pos
		wallet.show()
		
		player.got_wallet = false
		player.occured_interaction()
		hide_exclamation()

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()
	Pause.add_objective(objective_name)

func hide_exclamation():
	exclamation.hide()
	Pause.remove_objective(objective_name)
