extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var player = $"../Player"
@onready var exclamation = $Exclamation
@onready var statue = $"../Statue"
@onready var pickup = $Pickup
var talk_ready = false
var objective_name = "Find wallet"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking and visible:
		pickup.play()
		dialogue.get_dialogue("wallet")
		player.got_wallet = true
		hide_exclamation()
		statue.show_exclamation()
		self.hide()
		set_process(false)

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
