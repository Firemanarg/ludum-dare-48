extends Control

func _on_BackButton_pressed() -> void:
	print("entrei")
	get_tree().change_scene("res://scenes/Menu/TitleScreen.tscn")


func _on_HSlider_value_changed(value: float) -> void:
	pass # Replace with function body.
