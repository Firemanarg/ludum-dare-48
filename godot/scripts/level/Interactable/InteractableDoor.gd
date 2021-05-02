extends BaseInteractable
class_name InteractableDoor


var no_key_dialog = ["kd a chave"]

func _ready() -> void:
	pass

func interact() -> void:
	if LevelManager.picked_up_the_key:
		LevelManager.picked_up_the_key = false
		self.queue_free()
	else:
		LevelManager.show_dialog_box(no_key_dialog)
