extends BaseInteractive

func _ready():
	get_parent().get_node("CanvasLayer/DialogBox").visible = false

func interact() -> void:
	if LevelManager.picked_up_the_key:
		get_parent().queue_free()
	else:
		get_parent().get_node("CanvasLayer/DialogBox").visible = true
