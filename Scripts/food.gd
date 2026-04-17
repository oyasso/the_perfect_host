extends MeshInstance3D

@onready var player = $"../Player"
@onready var exclamation = $Exclamation
@export var other_food: Node3D
var talk_ready = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready:
		player.got_items = true
		player.acquired_items()
		hide_exclamation()
		other_food.hide_exclamation()
		queue_free()

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()

func hide_exclamation():
	exclamation.hide()
