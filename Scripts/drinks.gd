extends MeshInstance3D

@onready var player = $"../Player"
@onready var uncle = $"../Uncle"
@onready var exclamation = $Exclamation
@export var other_drinks: Node3D
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready:
		player.got_drinks = true
		uncle.show_exclamation()
		hide_exclamation()
		other_drinks.hide_exclamation()
		queue_free()

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()

func hide_exclamation():
	exclamation.hide()
