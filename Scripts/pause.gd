extends Control

@onready var objective = $CurrentObjective
@onready var hover = $Hover
@onready var close = $Close

var objectives = []
var paused = false
var can_pause = true
var dialogue_playing = false

func _input(event):
	if event.is_action_pressed("pause") and can_pause:
		toggle_pause()

func toggle_pause():
	if paused:
		resume()
	else:
		pause()

func pause():
	paused = true
	get_tree().paused = true
	get_parent().move_child(self, -1)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.show()

func resume(): 
	close.play()
	paused = false
	get_tree().paused = false
	if not dialogue_playing:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.hide()

func add_objective(item: String):
	if item not in objectives:
		objectives.append(item)
	update_objectives()

func remove_objective(item: String):
	objectives.erase(item)
	update_objectives()

func update_objectives():
	objective.text = ""
	for item in objectives:
		objective.text += item + "\n"

func _on_reset_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/title.tscn")

func _on_resume_button_pressed() -> void:
	resume()

func _on_button_mouse_entered() -> void:
	hover.play()
