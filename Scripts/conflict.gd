extends Node3D

@onready var dialogue = $DialogueUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.get_dialogue("fake1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if dialogue.next_dialogue == "fake11":
		turn_to_kiki()
	
	if dialogue.next_dialogue == "fake15":
		turn_to_lyra()
	
	if dialogue.next_dialogue == "fake21":
		turn_to_fama()


func turn_to_kiki():
	pass
	
func turn_to_lyra():
	pass

func turn_to_fama():
	pass
