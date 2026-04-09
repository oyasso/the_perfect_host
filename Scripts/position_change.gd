extends Node

@onready var mother = $"../Mother"
@onready var father = $"../Father"
@onready var uncle = $"../Uncle"
@onready var butler = $"../Butler"
@onready var fama = $"../Fama"
@onready var fancy_lady = $"../FancyLady"
@onready var fancy_man = $"../FancyMan"

func change_middle():
	mother.position = Vector3(-74.561, 0.4, -21.257)
	father.position = Vector3(-74.561, 0.4, -28.887)
	uncle.position = Vector3(-69, 0.4, 21)
