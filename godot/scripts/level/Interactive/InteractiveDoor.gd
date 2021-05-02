extends BaseInteractive

func interact() -> void:
	if LevelManager.picked_up_the_key:
		get_parent().queue_free()
	else:
		print("kd a chave")
