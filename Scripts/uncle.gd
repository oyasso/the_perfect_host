extends MeshInstance3D

@onready var dialogue = $"../DialogueUI"
@onready var mother = $"../Mother"
@onready var player = $"../Player"
@onready var exclamation = $Exclamation
@onready var fancy_lady = $"../FancyLady"
@onready var fancy_man = $"../FancyMan"
@onready var wallet = $"../Wallet"
@onready var items = [$"../Items", $"../Items2"]
@onready var tray = $"../Tray"
@onready var body_animation = $AnimationPerson
@onready var wallet_hidden_1 = $"../WalletHidden"
@onready var wallet_hidden_2 = $"../WalletHidden2"
var first_talk = false
var talk_ready = false
var drinks_counter = 0
var tray_talk = false
var objective_name = "Talk to Uncle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("talk") and talk_ready and not dialogue.is_talking:
		if first_talk:
			match drinks_counter:
				0:
					if tray_talk == false:
						if player.got_tray:
							dialogue.get_dialogue("tray")
							tray_talk = true
							hide_exclamation()
							items[0].show_exclamation()
							items[1].show_exclamation()
						elif not player.got_tray:
							dialogue.get_dialogue("notray")

					else:
						if player.got_items:
							dialogue.get_dialogue("drinks")
							drinks_counter += 1
							hide_exclamation()
							fancy_lady.show_exclamation()
							fancy_man.show_exclamation()
						else:
							dialogue.get_dialogue("nodrinks")
				1:
					dialogue.get_dialogue("alcohol")
					drinks_counter += 1
				2:
					dialogue.get_dialogue("second")
					drinks_counter += 1
				3:
					dialogue.get_dialogue("third")
					drinks_counter += 1
				4:
					dialogue.get_dialogue("fourth")
					drinks_counter += 1
				5:
					dialogue.get_dialogue("fifth")
					drinks_counter += 1
				6:
					dialogue.get_dialogue("sixth")

		if mother.talked_count > 0 and not first_talk:
			dialogue.get_dialogue("hair")
			first_talk = true
			hide_exclamation()
			tray.show_exclamation()

	#if first_talk and drinks_counter >= 1:
		#exclamation.hide()
	#if not first_talk and mother.talked_count == 1:
		#exclamation.show()

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

func drunk():
	body_animation.stop()
	body_animation.play("drunk")

func fall():
	body_animation.stop()
	body_animation.play("fall")
	await get_tree().create_timer(3.0).timeout
	wallet_hidden_1.hide()
	wallet_hidden_2.show()
