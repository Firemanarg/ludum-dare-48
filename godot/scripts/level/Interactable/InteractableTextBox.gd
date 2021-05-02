extends BaseInteractable
class_name InteractableTextBox

export var dialog = []

func _ready():
	pass

func interact() ->void:
	LevelManager.show_dialog_box(dialog)
	pass
