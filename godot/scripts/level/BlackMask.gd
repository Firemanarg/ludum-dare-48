extends ColorRect

onready var screen_dimensions = get_viewport().size
var player_position_uv : Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Convert player position to UV position
	player_position_uv = global_position / screen_dimensions
	# Set shader to player position
	get_parent().get_node("ShaderLayer/Torch").material.set_shader_param("player_position",player_position_uv)
