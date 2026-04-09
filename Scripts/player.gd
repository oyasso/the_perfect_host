extends CharacterBody3D

@onready var _camera := $CameraPivot/SpringArm3D/Camera3D as Camera3D
@onready var _camera_pivot := $CameraPivot as Node3D
@onready var walking = $Pivot/Kyoshi/AnimationPlayer
@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export var tilt_limit = deg_to_rad(75)
@export var speed = 14

# bool to check if in talk area
var talk_ready = false
var can_move = true

# bools to see inventory
@export var got_tray = false
@export var got_drinks = false
@export var got_food = false
@export var got_wallet = false

func _physics_process(delta):
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	direction = direction.rotated(Vector3.UP, _camera.global_rotation.y)

	if can_move:
		if direction != Vector3.ZERO:
			walking.play("Action_001")
			$Pivot.basis = Basis.looking_at(direction)
		else:
			walking.stop()
			
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y -= 9.81 * delta # adds gravity
		move_and_slide()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
		# prevent camera from rotating too far up or down
		_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		_camera_pivot.rotation.y += -event.relative.x * mouse_sensitivity
