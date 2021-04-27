extends Node2D
class_name BaseLevel

onready var objects = get_node("Objects")
onready var player = get_node("Objects/Player")


func _ready() -> void:
	Global.player = player
	Global.current_level = self
	update_global_light_sources()
	update_global_enemies()
	Global.nav_2d = get_node("Tilemaps")
	Global.Enemy = get_node("Enemy")
	Global._playerLife = 1
#	Global.light_sources.append(get_node("InteractiveLightSource"))
#	Global.light_sources.append(get_node("InteractiveLightSource2"))
#	custom_sign.connect("interacted", self, "show_textbox")
	pass

func update_global_light_sources():
	Global.light_sources = []
	for child in objects.get_children():
		if child is LightSource:
			Global.light_sources.append(child)

func update_global_enemies():
	Global.enemies = []
	for child in objects.get_children():
		if child is Enemy:
			Global.enemies.append(child)
