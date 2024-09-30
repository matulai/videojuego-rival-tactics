extends AbstractState

func update(delta: float) -> void:
	if character.navigation_agent.is_target_reached():
		print("reached")
		emit_signal("finished", "attack")
	else:
		character.chase()
		character.move()
