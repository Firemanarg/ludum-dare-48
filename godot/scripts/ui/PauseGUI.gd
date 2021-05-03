extends Control
class_name PauseGUI

var choosing_sound = preload("res://assets/audio/System sounds/Menu/Choosing.wav")
var selected_sound = preload("res://assets/audio/System sounds/Menu/Selected.wav")

onready var main_container = get_node("ContainerPauseGUI")
onready var slider_sound = get_node("ContainerPauseGUI/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer3/VBoxContainer/HSliderSound")
onready var slider_music = get_node("ContainerPauseGUI/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer3/VBoxContainer2/HSliderMusic")
onready var button_back = get_node("ContainerPauseGUI/PanelContainer/MarginContainer/VBoxContainer/CenterContainerBack/ButtonBack")
onready var tween = get_node("Tween")
onready var audio_player = get_node("AudioStreamPlayer")

export var anim_speed = 0.5
onready var initial_position = Vector2(-main_container.rect_size.x, 0)
var target_position = Vector2(0, 0)

var is_hide_pending = false

func _ready() -> void:
	self.visible = false
	main_container.rect_position = initial_position
	pass

func _process(delta: float) -> void:
	pass

func play_choosing_sound():
	adjust_audio_levels()
	audio_player.stream = choosing_sound.duplicate()
	audio_player.play()

func play_selected_sound():
	adjust_audio_levels()
	audio_player.stream = selected_sound.duplicate()
	audio_player.play()

func adjust_audio_levels():
	audio_player.volume_db = GameSettings.get_sound_volume()

func show():
	slider_sound.value = GameSettings.get_sound_level()
	slider_music.value = GameSettings.get_music_level()
	self.visible = true
	main_container.rect_position = initial_position
	interpolate_position(initial_position, target_position)
	pass

func hide():
	is_hide_pending = true
	main_container.rect_position = target_position
	interpolate_position(target_position, initial_position)
	pass

func interpolate_position(initial_position: Vector2, target_position: Vector2) -> void:
	tween.interpolate_property(
		main_container,
		"rect_position",
		initial_position,
		target_position,
		anim_speed,
		Tween.TRANS_QUAD,
		Tween.EASE_IN
	)
	tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if is_hide_pending:
		is_hide_pending = false
		self.visible = false
	pass


func _on_HSliderSound_value_changed(value: float) -> void:
	GameSettings.set_sound_level(value)
	adjust_audio_levels()
	pass


func _on_HSliderMusic_value_changed(value: float) -> void:
	GameSettings.set_music_level(value)
	adjust_audio_levels()
	pass


func _on_ButtonBack_pressed() -> void:
	play_selected_sound()
	LevelManager.unpause_game()
	pass


func _on_ButtonBack_mouse_entered() -> void:
	play_choosing_sound()
	pass


func _on_ButtonReturnMenu_pressed() -> void:
	play_selected_sound()
	pass


func _on_ButtonReturnMenu_mouse_entered() -> void:
	play_choosing_sound()
	pass
