extends BaseInteractable
class_name InteractableKey


func _ready() -> void:
	pass

func interact() -> void:
	LevelManager.picked_up_the_key = true
	self.queue_free()
