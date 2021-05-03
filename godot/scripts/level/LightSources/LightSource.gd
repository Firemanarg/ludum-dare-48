extends Light2D
class_name LightSource

const IMAGE_ORIGINAL_SIZE = 512
# To get radius, use function get_image_scale_by_step()

onready var tween = get_node("Tween")
onready var timer = get_node("Timer")

export var min_radius: float = 0.5
export var max_radius: float = 1.8
var tween_duration: float = 0.15
var current_step: int = 1
var light_steps: int = 5
export var is_enabled: bool = true

signal turned_on
signal turned_off

func _ready() -> void:
	timer.connect("timeout", self, "on_timer_timeout")
	tween.connect("tween_completed", self, "on_tween_completed")
	self.texture_scale = get_image_scale_by_step()
	pass

func get_radius(step = null) -> float:
	var result = (get_image_scale_by_step(step) * IMAGE_ORIGINAL_SIZE) * 0.3
#	print("radius = ", get_image_scale_by_step(), " | converted = ", result)
	return result

func get_image_scale_by_step(step = null) -> float:
	if light_steps == 1:
		return max_radius

	if not step:
		step = current_step
	return GlobalFunctions.map(step, 0, light_steps-1, min_radius, max_radius)

func set_image_scale(img_scale: float) -> void:
	var fixed_radius = clamp(img_scale, min_radius, max_radius)
	var step = GlobalFunctions.map(fixed_radius, min_radius, max_radius, 0, light_steps-1)
	step = int( round( clamp(step, 0.0, light_steps-1) ) )
	radius_transition(get_image_scale_by_step(), get_image_scale_by_step(step))
	current_step = step

func radius_transition(initial_scale: float, final_scale: float):
	tween.stop_all()
	tween.interpolate_property(self, "texture_scale", initial_scale, final_scale, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
#	print("Interpolating from ", initial_radius, " to ", final_radius)

func turn_on():
	if not self.visible:
		self.visible = true
		radius_transition(0.0, get_image_scale_by_step())
		is_enabled = true
		emit_signal("turned_on")

func turn_off():
	if self.visible:
		radius_transition(get_image_scale_by_step(), 0.0)
		timer.wait_time = tween_duration
		timer.start()
		emit_signal("turned_off")

func on_timer_timeout():
	self.visible = false
	is_enabled = false
