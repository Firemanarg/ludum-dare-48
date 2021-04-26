extends Light2D
class_name LightSource

# To get radius, use function get_radius()

onready var tween = get_node("Tween")
onready var timer = get_node("Timer")

export var min_radius = 0.5
export var max_radius = 1.8
var tween_duration = 0.15
var current_step = 1
var light_steps = 5
export var is_enabled = true

func _ready() -> void:
	timer.connect("timeout", self, "on_timer_timeout")
	tween.connect("tween_completed", self, "on_tween_completed")
	self.texture_scale = get_radius()
	pass


func get_radius(step = null):
	if not step:
		step = current_step
	return Global.map(step, 0, light_steps-1, min_radius, max_radius)

func set_radius(radius: float):
	var fixed_radius = clamp(radius, min_radius, max_radius)
	return Global.map(fixed_radius, min_radius, max_radius, 0, light_steps-1)

func radius_transition(initial_radius, final_radius):
	tween.stop_all()
	tween.interpolate_property(self, "texture_scale", initial_radius, final_radius, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	print("Interpolating from ", initial_radius, " to ", final_radius)

func turn_on():
	if not self.visible:
		self.visible = true
		radius_transition(0.0, get_radius())

func turn_off():
	if self.visible:
		radius_transition(get_radius(), 0.0)
		timer.wait_time = tween_duration
		timer.start()

func on_timer_timeout():
	self.visible = false
