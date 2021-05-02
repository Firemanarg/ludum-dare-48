extends BaseInteractive

func interact() -> void:
	LevelManager.picked_up_the_key = true
	get_parent().queue_free()
