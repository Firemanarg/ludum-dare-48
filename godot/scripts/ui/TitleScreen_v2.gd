extends Control
class_name TitleScreen

onready var button_play = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerPlay/ButtonPlay")
onready var button_options = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerOptions/ButtonOptions")
onready var button_credits = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerCredits/ButtonCredits")
onready var button_exit = get_node("Background/VBoxContainer/VBoxContainer/CenterContainerExit/ButtonExit")
onready var fade = get_node("Fade")

func _ready() -> void:
	fade.fade_in()
	pass

func _on_ButtonPlay_pressed() -> void:
	pass


func _on_ButtonOptions_pressed() -> void:
	pass


func _on_ButtonCredits_pressed() -> void:
	pass


func _on_ButtonExit_pressed() -> void:
	pass
