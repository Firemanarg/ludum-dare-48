extends Node

func _ready() -> void:
	Global.nav_2d = get_node("Navigation2D")
	Global.player = get_node("Player")
	Global.Enemy = get_node("Enemy")

