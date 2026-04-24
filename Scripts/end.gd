extends Node3D

@onready var fancy_lady = $FancyLady
@onready var uncle = $Uncle
@onready var mother = $Mother
@onready var dialogue = $DialogueUI
@onready var fade = $FadeOut

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.get_dialogue("afterfight")
	fancy_lady.chocking()
	mother.hide_exclamation()
	uncle.drunk()

func end_game():
	fade.show()
	fade.fade_in(1.5)
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
