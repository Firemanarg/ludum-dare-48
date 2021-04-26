extends KinematicBody2D

onready var light_source = get_node("PlayerLightSource")

var MAX_SPEED: = 300
var ACCELERATION: = 2000
var motion: = Vector2.ZERO
var last_axis: = Vector2(1,0)
onready var animation = get_node("AnimationPlayer")

func _physics_process(delta):
	var axis = get_input_axis()
	animation(axis)
	if (axis == Vector2.ZERO):
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_backward")) - int(Input.is_action_pressed("move_forward"))
	return axis.normalized()

func animation(axis) -> void:
	var next_animation
	if axis.x == 0 && axis.y == 0:
		if last_axis.x == 0 && last_axis.y > 0:
			next_animation = "idle_backward"
		elif last_axis.x == 0 && last_axis.y < 0:
			next_animation = "idle_foward"
		elif last_axis.x > 0 && last_axis.y == 0:
			next_animation = "idle_right"
		elif last_axis.x < 0 && last_axis.y == 0:
			next_animation = "idle_left"
		elif last_axis.x > 0 && last_axis.y > 0:
			next_animation = "idle_backward_right"
		elif last_axis.x < 0 && last_axis.y > 0:
			next_animation = "idle_backward_left"
		elif last_axis.x > 0 && last_axis.y < 0:
			next_animation = "idle_foward_right"
		elif last_axis.x < 0 && last_axis.y < 0:
			next_animation = "idle_foward_left"
	else:
		if axis.x == 0 && axis.y > 0:
			next_animation = "walk_backward"
		elif axis.x == 0 && axis.y < 0:
			next_animation = "walk_foward"
		elif axis.x > 0 && axis.y == 0:
			next_animation = "walk_right"
		elif axis.x < 0 && axis.y == 0:
			next_animation = "walk_left"
		elif axis.x > 0 && axis.y > 0:
			next_animation = "walk_backward_right"
		elif axis.x < 0 && axis.y > 0:
			next_animation = "walk_backward_left"
		elif axis.x > 0 && axis.y < 0:
			next_animation = "walk_foward_right"
		elif axis.x < 0 && axis.y < 0:
			next_animation = "walk_foward_left"
		last_axis = axis
	if next_animation != animation.current_animation:
		animation.play(next_animation)
#		print(animation.current_animation)
	
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
