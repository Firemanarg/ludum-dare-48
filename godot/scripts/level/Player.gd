extends KinematicBody2D

onready var light_source = get_node("PlayerLightSource")

var MAX_SPEED: = 300
var ACCELERATION: = 2000
var motion: = Vector2.ZERO

func _physics_process(delta):
	var axis = get_input_axis()
	if (axis == Vector2.ZERO):
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) #configurar outras teclas pelo key map depois
	axis.y = int(Input.is_action_pressed("move_backward")) - int(Input.is_action_pressed("move_forward"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
	if motion.length() > MAX_SPEED:
		motion = motion.normalized() * MAX_SPEED
