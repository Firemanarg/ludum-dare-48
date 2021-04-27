extends Control

func _ready() -> void:
	pass

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Level.tscn")
	pass # Replace with function body.

func _on_OptionsButton_pressed() -> void:
	get_tree().change_scene("res://scenes/Menu/OptionsScreen.tscn")

func _on_ExtraButton_pressed() -> void:
	pass # Replace with function body.

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
