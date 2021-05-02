extends BaseInteractive

func _ready():
	get_parent().get_node("CanvasLayer/DialogBox").visible = false

func interact() ->void:
	get_parent().get_node("CanvasLayer/DialogBox").visible = true
