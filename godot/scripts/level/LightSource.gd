extends Node2D
class_name LightSource

const INITIAL_PRC = 0.6

onready var gradient = get_node("Gradient")
onready var tween = get_node("Tween")
onready var timer = get_node("Timer")


var min_radius = 64
var max_radius = 512
var min_scale = 0.5
var max_scale = 1.3
var last_prc = INITIAL_PRC
var current_prc = INITIAL_PRC
var prc_step = 0.2
var tween_duration = 0.2

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var step_up = Input.is_action_just_pressed("light_step_up")
	var step_down = Input.is_action_just_pressed("light_step_down")
	var light_on = Input.is_action_just_pressed("light_turn_on")
	var light_off = Input.is_action_just_pressed("light_turn_off")

	if step_up:
		if current_prc + prc_step > 1.0:
			set_current_prc(1.0)
		else:
			set_current_prc(current_prc + prc_step)
	if step_down:
		if current_prc - prc_step < 0.00:
			set_current_prc(0.0)
		else:
			set_current_prc(current_prc - prc_step)
	if light_off:
		set_current_prc(0.0)
	if light_on:
		set_current_prc(1.0)


func current_radius():
	return Global.map(current_prc, 0.00, 1.0, min_radius, max_radius)

func target_radius():
	return Global.map(current_prc, 0.00, 1.0, min_radius, max_radius)

func last_radius():
	return Global.map(last_prc, 0.00, 1.0, min_radius, max_radius)

func calculate_radius(prc: float):
	return Global.map(prc, 0.00, 1.0, min_radius, max_radius)

func set_current_prc(value):
	if value >= 0.0 and value <= 1.0:
		last_prc = current_prc
		current_prc = value
		update_visual_radius()

func update_visual_radius():
	var last_scale_factor = Global.map(last_radius(), min_radius, max_radius, min_scale, max_scale)
	var target_scale_factor = Global.map(target_radius(), min_radius, max_radius, min_scale, max_scale)
	var last_scale = Vector2(last_scale_factor, last_scale_factor)
	var target_scale = Vector2(target_scale_factor, target_scale_factor)

	tween.interpolate_property(gradient, "scale", last_scale, target_scale, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	pass
