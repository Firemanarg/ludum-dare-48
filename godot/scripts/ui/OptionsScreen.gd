extends Control
class_name OptionsScreen

var choosing_sound = preload("res://assets/audio/System sounds/Menu/Choosing.wav")
var selected_sound = preload("res://assets/audio/System sounds/Menu/Selected.wav")

onready var audio_player = get_node("AudioStreamPlayer")
onready var fade = get_node("Fade")

func _ready() -> void:
	fade.fade_in()
	pass


func play_choosing_sound():
	audio_player.stream = choosing_sound.duplicate()
	audio_player.play()

func play_selected_sound():
	audio_player.stream = selected_sound.duplicate()
	audio_player.play()

func back_to_title_screen():
	get_tree().change_scene_to( GlobalLoaded.get_resource("Scene-TitleScreen") )


func _on_ButtonBack_pressed() -> void:
	fade.connect("fade_completed", self, "back_to_title_screen")
	play_selected_sound()
	fade.fade_out()
	pass


func _on_ButtonBack_mouse_entered() -> void:
	play_choosing_sound()
	pass
