extends LightSource


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var step_up = Input.is_action_just_pressed("light_step_up")
	var step_down = Input.is_action_just_pressed("light_step_down")
	var light_on = Input.is_action_just_pressed("light_turn_on")
	var light_off = Input.is_action_just_pressed("light_turn_off")

	if step_up:
		var radius = get_radius()
		current_step = clamp(current_step + 1, 0, light_steps-1)
		var new_radius = clamp(get_radius(current_step), min_radius, max_radius)
		radius_transition(radius, new_radius)
		print("step -> ", current_step)
	if step_down:
		var radius = get_radius()
		current_step = clamp(current_step - 1, 0, light_steps-1)
		var new_radius = clamp(get_radius(current_step), min_radius, max_radius)
		radius_transition(radius, new_radius)
		print("step -> ", current_step)
	if light_off:
		turn_off()
	if light_on:
		turn_on()
