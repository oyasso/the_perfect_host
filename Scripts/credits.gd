extends Control

@onready var stream = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BgMusic.player.stream = load("res://Sounds/Waltz Phase 1 V2.mp3")
	BgMusic.player.play()

func _process(_delta):
	if !stream.is_playing():
		end()

func end():
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
