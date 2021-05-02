extends LightSource
class_name InteractiveLightSource

onready var consume_timer = get_node("ConsumeTimer")

export(float) var radius = 0.5
onready var lifetime = 2.0

func _ready() -> void:
	consume_timer.connect("timeout", self, "turn_off")
#	turn_on()
	pass

func turn_on():
	self.visible = true
	radius_transition(0.0, get_radius())

	consume_timer.wait_time = lifetime
	consume_timer.start()

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
#func set_radius(radius: float):
#	var fixed_radius = clamp(radius, min_radius, max_radius)
#	return Global.map(fixed_radius, min_radius, max_radius, 0, light_steps-1)

