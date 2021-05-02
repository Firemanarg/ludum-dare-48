extends Node2D
class_name LoadingScreen

onready var fade = get_node("CanvasLayer/Fade")

func _ready() -> void:
	GlobalLoaded.loading_screen = self
	fade.connect("fade_completed", self, "goto_level_scene")
	GlobalLoaded.add_resource_to_query("Scene-TestLevel", "res://scenes/level/PlayableLevels/TestLevel.tscn")
	GlobalLoaded.add_resource_to_query("Scene-TitleScreen", "res://scenes/ui/TitleScreen.tscn")
	GlobalLoaded.start_load()
	pass

func _on_loading_ready():
	fade.fade_out()
	pass

func goto_level_scene():
	get_tree().change_scene_to( GlobalLoaded.get_resource("Scene-TitleScreen") )
	pass

#func _ready() -> void:
#	ResourceQueue.start()
#	ResourceQueue.queue_resource("res://scenes/level/PlayableLevels/TestLevel.tscn")
#	ResourceQueue.queue_resource("res://scenes/ui/TitleScreen.tscn")
##	GlobalLoaded.start_load()
##	GlobalLoaded.add_resource_to_queue("Scene-TestLevel", "res://scenes/level/PlayableLevels/TestLevel.tscn")
##	GlobalLoaded.add_resource_to_queue("Scene-TitleScreen", "res://scenes/ui/TitleScreen.tscn")
#	pass

#func _process(delta: float) -> void:
#
#	var base_level = ResourceQueue.get_resource("res://scenes/level/PlayableLevels/TestLevel.tscn")
#	var title_screen = ResourceQueue.get_resource("res://scenes/ui/TitleScreen.tscn")
#
#	var count = 0
#	if base_level:
##		GlobalLoaded.level = level
#		GlobalLoaded.loaded_resources["base-level"] = base_level
#		count += 1
#	if title_screen:
#		GlobalLoaded.loaded_resources["title-screen"] = title_screen
#		count += 1
#
#	if count == 2:
#		get_tree().change_scene_to( GlobalLoaded.loaded_resources["title-screen"] )



#	if GlobalLoaded.has_ended():
#		get_tree().change_scene_to(GlobalLoaded.get_resource("Scene-TitleScreen"))

	pass
