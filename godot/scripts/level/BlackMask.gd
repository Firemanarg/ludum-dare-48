extends ColorRect

onready var screen_dimensions = get_viewport().size

var light_sources_uv = []
var light_sources_radius = []
var uv_array_width = 0
var radius_array_width = 0
var uv_array_height = 0
var radius_array_height = 0

func _ready():
#	# The array I want to send to my shader
#	var array = [1, 1, 1, 0, 2, 2, 2, 0, 0, 3]
#
#	# You'll have to get thoose the way you want
#	var array_width = 10
#	var array_heigh = 1

	# Add all light sources
	for light_source in Global.light_sources:
		add_light_source(light_source)

	# The following is used to convert the array into a Texture
	var byte_array_uv = PoolByteArray(light_sources_uv)
	var img_uv = Image.new()
	var byte_array_radius = PoolByteArray(light_sources_radius)
	var img_radius = Image.new()

	# I don't want any mipmaps generated : use_mipmaps = false
	# I'm only interested with 1 component per pixel (the corresponding array value) : Format = Image.FORMAT_R8
	img_uv.create_from_data(uv_array_width, uv_array_height, false, Image.FORMAT_R8, byte_array_uv)
	img_radius.create_from_data(radius_array_width, radius_array_height, false, Image.FORMAT_R8, byte_array_radius)

	var texture_uv = ImageTexture.new()
	var texture_radius = ImageTexture.new()

	# Override the default flag with 0 since I don't want texture repeat/filtering/mipmaps/etc
	texture_uv.create_from_image(img_uv, 0)
	texture_radius.create_from_image(img_radius, 0)

	# Upload the texture to my shader
	material.set_shader_param("light_sources_uv", texture_uv)
	material.set_shader_param("light_sources_radius", texture_radius)

func _process(delta: float) -> void:
	for i in len(light_sources_radius):
		# Implementar verificação se o light source é a lamparina do player
		pass
	pass

func add_light_source(light_source: LightSource):
	var light_source_uv = light_source.global_position / screen_dimensions
	light_sources_uv.append( [light_source_uv.x, light_source_uv.y] )
	light_sources_radius.append( light_source.current_radius() )
	uv_array_width += 1
	uv_array_height = 2
	radius_array_width += 1
	radius_array_height = 1


func remove_light_source(index: int):
	if index >= 0 and index < len(light_sources_uv):
		light_sources_uv.remove(index)
		light_sources_radius.remove(index)


func update_light_source_uv(index: int):
	if index >= 0 and index < len(light_sources_uv):
		var light_source = Global.light_sources[index]
		var light_source_uv = light_source.global_position / screen_dimensions
		light_sources_uv[index] = [light_source_uv.x, light_source_uv.y]

func update_light_source_radius(index: int):
	if index >= 0 and index < len(light_sources_uv):
		var light_source = Global.light_sources[index]
		light_sources_uv[index] = light_source.current_radius()
