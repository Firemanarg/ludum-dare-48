extends Node

onready var custom_sign = get_node("Area2D")

func _ready() -> void:
	Global.nav_2d = get_node("Navigation2D")
	Global.player = get_node("Player")
	Global.Enemy = get_node("Enemy")
	Global._playerLife = 1
	custom_sign.connect("interacted", self, "show_textbox")

func show_textbox () -> void:
	$CanvasLayer/Control.visible = true
