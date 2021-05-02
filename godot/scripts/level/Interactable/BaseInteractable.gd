extends Node2D
class_name BaseInteractable

onready var area2d = get_node("Area2D")
onready var sprite = get_node("Sprite")

var can_interact = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not Engine.editor_hint:
		var interact_key = Input.is_action_just_pressed("interact")
		if interact_key && can_interact:
			interact()

func interact() -> void:
	print("Key E pressed")

func action_body_entered(body):
	if body is Player:
		can_interact = true
	pass

func action_body_exited(body):
	if body is Player:
		can_interact = false
	pass


func _on_Area2D_body_entered(body: Node) -> void:
	action_body_entered(body)
	pass


func _on_Area2D_body_exited(body: Node) -> void:
	action_body_exited(body)
	pass
