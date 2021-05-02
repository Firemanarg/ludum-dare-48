extends BaseInteractive

export var dialog = ["Fala cumpadi", "Tudo Bao ?", "Bo cume uma pamonha com peixe", "Bo"]

func _ready():
	pass
#	get_parent().get_node("CanvasLayer/DialogBox").visible = false

func interact() ->void:
	LevelManager.current_level.show_dialog_box(dialog)
#	get_parent().get_node("CanvasLayer/DialogBox").visible = true
