extends Node3D

@onready var dialogue = $DialogueUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.get_dialogue("afterfight")
