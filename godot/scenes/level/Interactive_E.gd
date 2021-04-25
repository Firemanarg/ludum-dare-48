extends Area2D

signal interacted
var can_interact = false
onready var chatbox = $Control
onready var node = get_node("CanvasLayer/Control")

func _on_Area2D_body_entered(body: Node) -> void:
	if body == Global.player:
		can_interact = true


func _on_Area2D_body_exited(body: Node) -> void:
	if body == Global.player:
		can_interact = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact == true:
		emit_signal("interacted")
		pass
