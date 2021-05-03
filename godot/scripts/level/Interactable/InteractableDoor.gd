extends BaseInteractable
class_name InteractableDoor


var no_key_dialog = ["kd a chave"]

func _ready() -> void:
	pass

func interact() -> void:
	if LevelManager.is_key_picked_up():
		LevelManager.reset_key_pickup()
		self.queue_free()
	else:
		LevelManager.show_dialog_box(no_key_dialog)
