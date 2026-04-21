extends Node3D

@onready var fade = $FadeOut

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.show()
	fade.fade_out(2.5)
