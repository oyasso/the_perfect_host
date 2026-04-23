extends MeshInstance3D

@onready var player = $"../Player"
@onready var uncle = $"../Uncle"
@onready var exclamation = $Exclamation
@onready var pickup = $Pickup
var talk_ready = false
var objective_name = "Pick up tray"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready:
		pickup.play()
		player.got_tray = true
		player.acquired_plate()
		uncle.show_exclamation()
		hide_exclamation()
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
