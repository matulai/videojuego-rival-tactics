extends AbstractState

func update(delta: float) -> void:
	character.handle_input()
	if character.move_direction == Vector2.ZERO:
		# Y cambiamos el estado a walk
		emit_signal("finished", "idle")
	character.move()
