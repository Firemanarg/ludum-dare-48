extends Node

var nav_2d : Navigation2D = null
var enemy : Enemy = null
var player : Player = null
var _playerLife : int = 0
var picked_up_the_key = false

var enemies : Array = []
var light_sources: Array = []
var current_level = null

var is_game_active = true

func is_game_active():
	return is_game_active

func set_game_active(state: bool):
	is_game_active = state

func show_dialog_box(dialog):
	if current_level:
		current_level.show_dialog_box(dialog)

func hide_dialog_box():
	if current_level:
		current_level.hide_dialog_box()

func get_player_life() -> int:
	return _playerLife

func set_player_life(value: int) -> void:
	_playerLife = value

func is_key_picked_up() -> bool:
	return picked_up_the_key

func pickup_key():
	picked_up_the_key = true

func reset_key_pickup():
	picked_up_the_key = false
