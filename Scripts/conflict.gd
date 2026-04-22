extends Node3D

@onready var dialogue = $DialogueUI
@onready var fade = $FadeOut
@onready var mother = $"Mother"
@onready var father = $"Father"
@onready var fama = $"Fama"
@onready var fancy_lady = $"FancyLady"
@onready var player = $Player
@onready var uncle = $Uncle
@onready var cam1 = $Cam01
@onready var cam2 = $Cam02

var fama_crawled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.get_dialogue("fake1")
	fade.show()
	fade.fade_out(1.0)
	mother.hide_exclamation()
	fancy_lady.chocking()
	uncle.drunk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if dialogue.next_dialogue == "fake11":
		turn_to_kiki()
	
	if dialogue.next_dialogue == "fake15":
		turn_to_lyra()
	
	if dialogue.next_dialogue == "fake19":
		turn_to_statue()
	
	if dialogue.next_dialogue == "fake21" and not fama_crawled:
		turn_to_fama()
		fama_crawled = true
	
	if dialogue.next_dialogue == "fake22":
		turn_to_parents()

func turn_to_kiki():
	rotate_person(mother, 15)
	rotate_person(father, -15)
	rotate_person(fancy_lady, -60)
	#mother.rotation_degrees = Vector3(0, 15, 0)
	#father.rotation_degrees = Vector3(0, -15, 0)
	#fancy_lady.rotation_degrees = Vector3(0, -60, 0)

func turn_to_lyra():
	rotate_person(mother, 75)
	rotate_person(father, 60)
	rotate_player(-45)
	#mother.rotation_degrees = Vector3(0, 75, 0)
	#father.rotation_degrees = Vector3(0, 60, 0)
	#player.rotation_degrees = Vector3(0, -45, 0)

func turn_to_statue():
	rotate_person(mother, 165)
	rotate_person(father, -165)
	rotate_player(0)

func turn_to_fama():
	cam2.current = true
	rotate_person(mother, 0)
	rotate_person(father, 0)
	rotate_player(180)
	#mother.rotation_degrees = Vector3(0, 0, 0)
	#father.rotation_degrees = Vector3(0, 0, 0)
	#fancy_lady.rotation_degrees = Vector3(0, -15, 0)
	#player.rotation_degrees = Vector3(0, 0, 0)
	fama.crawl()

func turn_to_parents():
	cam1.current = true
	rotate_player(0)

func rotate_person(person: MeshInstance3D, degrees: int):
	var tween = create_tween()
	tween.tween_property(person, "rotation_degrees:y", degrees, 1.0)

func rotate_player(degrees: int):
	var tween = create_tween()
	tween.tween_property(player, "rotation_degrees:y", degrees, 1.0)

func end_conflict_scene():
	fade.show()
	fade.fade_in(1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/boss_battle.tscn")
