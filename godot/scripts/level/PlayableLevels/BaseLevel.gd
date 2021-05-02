extends Node2D
class_name BaseLevel

onready var objects = get_node("Objects")
onready var player = get_node("Objects/Player")
onready var fade = get_node("CanvasLayer/Fade")
onready var audio_player = get_node("AudioStreamPlayerMusic")


func _ready() -> void:
	fade.fade_in(1.0)
	LevelManager.player = player
	LevelManager.current_level = self
	update_LevelManager_light_sources()
	update_LevelManager_enemies()
	LevelManager.nav_2d = get_node("Tilemaps")
	LevelManager.Enemy = get_node("Enemy")
	LevelManager._playerLife = 1
#	LevelManager.light_sources.append(get_node("InteractiveLightSource"))
#	LevelManager.light_sources.append(get_node("InteractiveLightSource2"))
#	custom_sign.connect("interacted", self, "show_textbox")
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_select"):
		get_node("CanvasModulate").visible = false
	else:
		get_node("CanvasModulate").visible = true

func update_LevelManager_light_sources():
	LevelManager.light_sources = []
	for child in objects.get_children():
		if child is LightSource:
			LevelManager.light_sources.append(child)

func update_LevelManager_enemies():
	LevelManager.enemies = []
	for child in objects.get_children():
		if child is Enemy:
			LevelManager.enemies.append(child)
