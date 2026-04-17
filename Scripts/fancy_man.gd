extends MeshInstance3D

@onready var player = $"../Player"
@onready var dialogue = $"../DialogueUI"
@onready var exclamation = $Exclamation
@onready var body_animation = $AnimationPerson
@onready var glass_animation = $AnimationGlass
@onready var glass = $"Wine Glass_002"
var talk_ready = false
var gave_drink = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("talk") and talk_ready and not dialogue.is_talking:		
		if not gave_drink:
			if player.got_items:
				dialogue.get_dialogue("beverage")
				player.occured_interaction()
				hide_exclamation()
			else:
				dialogue.get_dialogue("nobeverage")
		else:
			dialogue.get_dialogue("notalk")

func _on_talk_area_body_entered(_body: Node3D) -> void:
	talk_ready = true

func _on_talk_area_body_exited(_body: Node3D) -> void:
	talk_ready = false

func show_exclamation():
	exclamation.show()

func hide_exclamation():
	exclamation.hide()

func drink():
	glass.show()
	body_animation.stop()
	body_animation.play("drinking")
	glass_animation.play("drinking_glass")
