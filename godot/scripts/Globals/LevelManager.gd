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

var jumpscare_in_progress = false

func _ready() -> void:
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	pass

func _process(delta: float) -> void:
	if current_level:
		var switch = Input.is_action_just_pressed("pause_game")
		if switch:
			print("Pause game action just pressed")
			if is_game_active:
				pause_game()
			else:
				unpause_game()
	pass

func is_jumpscare_in_progress():
	return jumpscare_in_progress

func is_game_active():
	return is_game_active

func set_game_active(state: bool):
	is_game_active = state

func deal_damage_to_player(enemy: Enemy):
	current_level.generate_jumpscare(enemy)
	LevelManager.set_player_life(0)

func pause_game():
	is_game_active = false
	if current_level:
		current_level.get_tree().paused = true
		if not is_jumpscare_in_progress():
			current_level.pause_gui.show()
			current_level.fade.fade_out()
#		current_level.pause_mode = Node.PAUSE_MODE_STOP

func unpause_game():
	is_game_active = true
	if current_level:
		current_level.get_tree().paused = false
		if not is_jumpscare_in_progress():
			current_level.pause_gui.hide()
			current_level.fade.fade_in()
#		current_level.pause_mode = Node.PAUSE_MODE_INHERIT

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
