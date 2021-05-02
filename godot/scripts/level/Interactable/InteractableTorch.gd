tool
extends BaseInteractable
class_name InteractableTorch


onready var light_source = get_node("InteractiveLightSource")

export var radius = 1.8
export var is_enabled = true
export var lifetime = 2.0
export var transition_duration = 0.15


func _ready() -> void:
	light_source.min_radius = 0.0
	light_source.max_radius = radius
	light_source.radius = radius
	print("Steps before: ", light_source.light_steps)
	light_source.light_steps = 1
	print("Steps after: ", light_source.light_steps)
	light_source.current_step = 1
	light_source.turn_off()
#	print("Light Source Radius: R=", light_source.get_radius(), " | C=", light_source.get_radius_converted())
	pass


func _process(delta: float) -> void:
	if Engine.editor_hint:
		var editor_light = get_node("EditorLight")
		editor_light.texture_scale = radius
		editor_light.visible = is_enabled
		pass


func turn_on():
	light_source.turn_on()

func turn_off():
	light_source.turn_off()


func action_body_entered(body):
	.action_body_entered(body)
	if body is Enemy:
		enemy_interact()
	pass

func interact():
	light_source.turn_on()

func enemy_interact() -> void:
	light_source.turn_off()
