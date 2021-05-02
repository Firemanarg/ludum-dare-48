extends Node2D
class_name LoadingScreen

onready var fade = get_node("CanvasLayer/Fade")
onready var loading_text = get_node("CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/LoadingText")

var loading_text_timer = 0
var loading_text_delay = 0.5
var loading_text_step = 0

func _ready() -> void:
	GlobalLoaded.loading_screen = self
	fade.connect("fade_completed", self, "goto_level_scene")
	GlobalLoaded.add_resource_to_query("Scene-TestLevel", "res://scenes/level/PlayableLevels/TestLevel.tscn")
	GlobalLoaded.add_resource_to_query("Scene-TitleScreen", "res://scenes/ui/TitleScreen.tscn")
	GlobalLoaded.add_resource_to_query("Scene-OptionsScreen", "res://scenes/ui/OptionsScreen.tscn")
	GlobalLoaded.start_load()
	pass

func _process(delta: float) -> void:
	if loading_text_timer >= loading_text_delay:
		loading_text_timer = 0
		match loading_text_step:
			0:
				loading_text.text = "Loading"
				loading_text_step += 1
			1:
				loading_text.text = "Loading."
				loading_text_step += 1
			2:
				loading_text.text = "Loading.."
				loading_text_step += 1
			3:
				loading_text.text = "Loading..."
				loading_text_step = 0
	else:
		loading_text_timer += delta


func _on_loading_ready():
	fade.fade_out()
	pass

func goto_level_scene():
	get_tree().change_scene_to( GlobalLoaded.get_resource("Scene-TitleScreen") )
	pass

