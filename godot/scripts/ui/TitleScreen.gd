extends Control
class_name TitleScreen

var choosing_sound = preload("res://assets/audio/System sounds/Menu/Choosing.wav")
var selected_sound = preload("res://assets/audio/System sounds/Menu/Selected.wav")

onready var button_play = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerPlay/ButtonPlay")
onready var button_options = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerOptions/ButtonOptions")
onready var button_credits = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerCredits/ButtonCredits")
onready var button_exit = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerExit/ButtonExit")
onready var fade = get_node("Fade")
onready var audio_player = get_node("AudioStreamPlayer")

func _ready() -> void:
	fade.fade_in()
	pass

func play_choosing_sound():
	audio_player.stream = choosing_sound.duplicate()
	audio_player.play()

func play_selected_sound():
	audio_player.stream = selected_sound.duplicate()
	audio_player.play()


func play_action():
	get_tree().change_scene_to(load("res://scenes/level/PlayableLevels/TestLevel.tscn"))
	pass

func options_action():
	pass

func credits_action():
	pass

func exit_action():
	pass


func _on_ButtonPlay_pressed() -> void:
	play_selected_sound()
	fade.connect("fade_completed", self, "play_action")
	fade.fade_out()
	pass


func _on_ButtonOptions_pressed() -> void:
	play_selected_sound()
	fade.connect("fade_completed", self, "options_action")
	fade.fade_out()
	pass


func _on_ButtonCredits_pressed() -> void:
	play_selected_sound()
	fade.connect("fade_completed", self, "credits_action")
	fade.fade_out()
	pass


func _on_ButtonExit_pressed() -> void:
	play_selected_sound()
	fade.connect("fade_completed", self, "exit_action")
	fade.fade_out()
	pass


func _on_ButtonPlay_mouse_entered() -> void:
	play_choosing_sound()
	pass


func _on_ButtonOptions_mouse_entered() -> void:
	play_choosing_sound()
	pass


func _on_ButtonCredits_mouse_entered() -> void:
	play_choosing_sound()
	pass


func _on_ButtonExit_mouse_entered() -> void:
	play_choosing_sound()
	pass
