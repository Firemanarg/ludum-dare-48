extends ColorRect
class_name Fade

onready var tween = get_node("Tween")

export(float, 0.0, 5.0) var fade_time = 1.0
export var initial_color = Color(0, 0, 0, 0)
export var target_color = Color(0, 0, 0, 1)
var current_fade = fade_type.NO_FADE
enum fade_type {
	NO_FADE,
	FADE_IN,
	FADE_OUT
}

signal fade_completed

func _ready() -> void:
	pass

func fade_in(duration: float = fade_time):
	mouse_filter = MOUSE_FILTER_STOP
	tween.interpolate_property(
		self,
		"color",
		target_color,
		initial_color,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	tween.start()
	current_fade = fade_type.FADE_IN
	pass

func fade_out(duration: float = fade_time):
	mouse_filter = MOUSE_FILTER_STOP
	tween.interpolate_property(
		self,
		"color",
		initial_color,
		target_color,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	tween.start()
	current_fade = fade_type.FADE_OUT
	pass


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	mouse_filter = MOUSE_FILTER_IGNORE
	emit_signal("fade_completed")
	pass
