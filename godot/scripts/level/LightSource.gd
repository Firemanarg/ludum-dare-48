extends Node2D
class_name LightSource

onready var gradient = get_node("Gradient")

var min_radius = 64
var max_radius = 512
var current_prc = 0.6
var prc_step = 0.2


func _init() -> void:
	pass

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var step_up = Input.is_action_just_pressed("light_step_up")
	var step_down = Input.is_action_just_pressed("light_step_down")
	var light_on = Input.is_action_just_pressed("light_turn_on")
	var light_off = Input.is_action_just_pressed("light_turn_off")

	if step_up:
		if current_prc + prc_step > 1.0:
			current_prc = 1.0
		else:
			current_prc += prc_step
	if step_down:
		if current_prc - prc_step < 0.0:
			current_prc = 0.0
		else:
			current_prc -= prc_step
	if light_on:
		current_prc = 0.0
	if light_off:
		current_prc = 1.0


func current_radius():
	return Global.map(current_prc, 0.0, 1.0, min_radius, max_radius)


func update_visual_radius():
	var texture_size = gradient.texture.get_size()
	var adjust_factor = texture_size / min_radius
	var final_size = texture_size
