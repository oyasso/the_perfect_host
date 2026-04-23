extends Node3D

@onready var fade = $FadeOut
@onready var uncle = $Uncle
@onready var mother = $Mother

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.show()
	fade.fade_out(1.0)
	uncle.body_animation.play("reset")
	mother.show_exclamation()
	BgMusic.player.stream = load("res://Sounds/Waltz Phase 1 V2.mp3")
	BgMusic.player.play()
	Pause.can_pause = true
