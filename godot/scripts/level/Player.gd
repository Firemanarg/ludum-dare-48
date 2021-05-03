extends KinematicBody2D
class_name Player

onready var animation = get_node("AnimationPlayer")
onready var light_source = get_node("PlayerLightSource")
onready var steps_audio_player = get_node("StepsSoundAudioPlayer")

export var MAX_SPEED: = 300
export var ACCELERATION: = 2000
var motion: = Vector2.ZERO
var last_axis: = Vector2(1,0)

var step_sounds = {
	str(BaseLevel.ground_tiles.GRASS): preload("res://assets/audio/Character Sounds/Walking/Grass/PlayerStepsOnGrass.wav"),
	str(BaseLevel.ground_tiles.STONE): preload("res://assets/audio/Character Sounds/Walking/Concrete/PlayerStepsOnConcrete.wav"),
	str(BaseLevel.ground_tiles.DIRT): preload("res://assets/audio/Character Sounds/Walking/Water/PlayerStepsOnWater.wav")
}

func _physics_process(delta):
	var axis = get_input_axis()
	animation(axis)
	if (axis == Vector2.ZERO):
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		if collider is Enemy:
			take_damage()

func update_step_sound():
	if LevelManager.current_level:
		var tile = LevelManager.current_level.get_tile_under_player()
		set_step_sound(tile)

func set_step_sound(ground_tile: int):
	if str(ground_tile) in step_sounds.keys():
		if not steps_audio_player.stream == step_sounds[str(ground_tile)]:
			steps_audio_player.stream = step_sounds[str(ground_tile)]

func play_step_sound():
#	if steps_audio_player.stream and not steps_audio_player.playing:
	if steps_audio_player.stream and not steps_audio_player.playing:
		print("Beginning play steps sound")
		steps_audio_player.play()

func get_input_axis():
	var axis = Vector2.ZERO

	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_backward")) - int(Input.is_action_pressed("move_forward"))
	return axis.normalized()

func animation(axis) -> void:
	var next_animation
	if axis.x == 0 && axis.y == 0:
		if last_axis.x == 0 && last_axis.y < 0:
			next_animation = "idle_foward"
		elif last_axis.x == 0 && last_axis.y > 0:
			next_animation = "idle_backward"
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
		update_step_sound()
		play_step_sound()
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

func take_damage():
	if LevelManager._playerLife > 0:
		LevelManager._playerLife -= 1
		print("You died !!!")

