extends MeshInstance3D

@onready var player = $"../Player"
@onready var exclamation = $Exclamation
@onready var uncle = $"../Uncle"
@export var other_food: Node3D
var talk_ready = false
var objective_name = "Get food and drinks"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and player.got_tray:
		player.got_items = true
		player.acquired_items()
		hide_exclamation()
		other_food.hide_exclamation()
		uncle.show_exclamation()
		queue_free()

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()
	Pause.add_objective(objective_name)

func hide_exclamation():
	exclamation.hide()
	Pause.remove_objective(objective_name)
