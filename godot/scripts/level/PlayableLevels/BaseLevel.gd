extends Node2D
class_name BaseLevel

onready var objects = get_node("Objetos")
onready var player = get_node("Objects/Player")

func _ready() -> void:
	Global.player = player
	Global.current_level = self
	update_global_light_sources()


func update_global_light_sources():
	Global.light_sources = []
	for child in objects.get_children():
		if child is LightSource:
			Global.light_sources.append(child)
