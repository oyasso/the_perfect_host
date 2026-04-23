extends CharacterBody3D

@export var use_camera := true

@onready var dialogue = $"../DialogueUI"
@onready var _camera := $CameraPivot/SpringArm3D/Camera3D as Camera3D
@onready var _camera_pivot := $CameraPivot as Node3D
@onready var body_animation = $Pivot/Kyoshi/AnimationPerson
@onready var plate_animation = $Pivot/Kyoshi/AnimationPlate
@onready var empty_tray = $Pivot/Kyoshi/"Empty Tray"
@onready var full_tray = $Pivot/Kyoshi/"Tray with items"
@onready var walk_sound = $Walk
@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export var tilt_limit = deg_to_rad(75)
@export var speed = 14

# bool to check if in talk area
var talk_ready = false
var can_move = true

var current_walk = "no_tray"
var current_tray = "no_tray"

# bools to see inventory
@export var got_tray = false
@export var got_items = false
@export var got_wallet = false

# count occured interactions
var interactions = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if use_camera:
		_camera.make_current()
	else:
		_camera.current = false

func _physics_process(delta):
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	direction = direction.rotated(Vector3.UP, _camera.global_rotation.y)

	if can_move:
		if direction != Vector3.ZERO:
			body_animation.play(current_walk)
			plate_animation.play(current_tray)
			$Pivot.basis = Basis.looking_at(direction)
			if not walk_sound.playing:
				walk_sound.play()
		else:
			body_animation.stop()
			plate_animation.stop()
			walk_sound.stop()
			
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y -= 9.81 * delta # adds gravity
		move_and_slide()
	else:
		body_animation.stop()
		plate_animation.stop()
		walk_sound.stop()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
		# prevent camera from rotating too far up or down
		_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		_camera_pivot.rotation.y += -event.relative.x * mouse_sensitivity

func occured_interaction():
	interactions += 1
	
	#if can_move:
		#if interactions == 2:
			#dialogue.get_dialogue("goingon")
#
		#if interactions == 3:
			#dialogue.get_dialogue("fake1")

func acquired_plate():
	current_walk = "walk_tray"
	current_tray = "tray_empty"
	empty_tray.show()

func acquired_items():
	current_tray = "tray_full"
	empty_tray.hide()
	full_tray.show()
