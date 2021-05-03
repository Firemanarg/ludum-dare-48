extends BaseInteractable
class_name InteractableKey


func _ready() -> void:
	pass

func interact() -> void:
	LevelManager.pickup_key()
	self.queue_free()
