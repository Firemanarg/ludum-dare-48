extends BaseInteractive

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		can_interact = true
	elif body is Enemy:
		enemyInteract()

func interact() ->void:
	print("Torch")

func enemyInteract() -> void:
	#if torch is on
	print("Heheheehehehehe")
