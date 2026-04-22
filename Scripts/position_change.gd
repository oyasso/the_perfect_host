extends Node

@onready var mother = $"../Mother"
@onready var father = $"../Father"
@onready var uncle = $"../Uncle"
@onready var butler = $"../Butler"
@onready var fama = $"../Fama"
@onready var fancy_lady = $"../FancyLady"
@onready var fancy_man = $"../FancyMan"
@onready var player = $"../Player"
@onready var fade = $"../FadeOut"

func change_middle():
	#fade.show()
	#fade.fade_out(1.0)
	mother.position = Vector3(-74.561, 0.7, -21.257)
	father.position = Vector3(-74.561, 1.1, -28.887)
	#uncle.position = Vector3(-69, 0.4, 21)

func change_uncle():
	fade.show()
	fade.fade_out(1.0)
	uncle.position = Vector3(-100.6, 7.2, 0.0)
	uncle.rotation_degrees = Vector3(0, 0, 0)
	#fancy_lady.position = Vector3(-66, 0.4, -20)
	#fancy_lady.rotation_degrees = Vector3(0, -30, 0)
	#uncle.position = Vector3(-95, 7.2, 0)
	#butler.position = Vector3(-120, 19.5, 0)
	#butler.rotation_degrees = Vector3(0, 0, 0)
	#player.position = Vector3(-58, 0.748, 0)
	#fama.show()
	#fama.crawl()
#
#func change_end():
	#fade_out.show()
	#fade_out.fade_out()
	#uncle.position = Vector3(-105, 12.75, -15)
