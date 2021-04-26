tool
extends LightSource
class_name InteractiveLightSource


export(float) var radius = 0.5


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Engine.editor_hint:
		# low2 + (value - low1) * (high2 - low2) / (high1 - low1)
		var fixed_radius = clamp(radius, min_radius, max_radius)
		self.texture_scale = map(fixed_radius, min_radius, max_radius, 0, light_steps-1)
#		self.texture_scale = min_radius + current_step \
#		* (max_radius - min_radius) / (light_steps-1)

		if is_enabled:
			self.visible = true
		else:
			self.visible = false

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
#func set_radius(radius: float):
#	var fixed_radius = clamp(radius, min_radius, max_radius)
#	return Global.map(fixed_radius, min_radius, max_radius, 0, light_steps-1)
