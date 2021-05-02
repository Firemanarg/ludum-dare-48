extends Control
class_name DialogBox

export var dialog = []

var dialog_index = 0
var finished = false

func _process(delta):
	if(dialog_index == 0):
		load_dialog()
	if Input.is_action_just_pressed("ui_accept"):
		if finished == true:
			load_dialog()
		else:
			$RichTextLabel.percent_visible =  1.0
			finished = true
			$Tween.stop_all()

func load_dialog():
	print("Loading dialog ", dialog_index, "/", dialog.size())
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		dialog_index += 1
	else:
		dialog_index = 0
		self.visible = false

func has_finished() -> bool:
	return dialog_index >= dialog.size()

func _on_Tween_tween_completed(object, key):
	finished = true
