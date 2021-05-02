extends Node

var nav_2d : Navigation2D = null
var Enemy : Enemy = null
var player : Player = null
var _playerLife : int = 0
var picked_up_the_key = false

var enemies : Array = []
var light_sources: Array = []
var current_level = null

var is_game_active = true

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)

func is_game_active():
	return is_game_active

func show_dialog_box(dialog):
	if current_level:
		current_level.show_dialog_box(dialog)

func hide_dialog_box():
	if current_level:
		current_level.hide_dialog_box()
