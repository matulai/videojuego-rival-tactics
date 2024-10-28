extends AbstractState

func update(delta: float) -> void:
	character.chase()
	character.move()

	if is_instance_valid(character.target):
		#Ataco si el enemigo esta cerca, distancia definida en NavigationAgent2D
		if character.navigation_agent.is_target_reached():
			emit_signal("finished", "attack")
	else:
		emit_signal("finished", "idle")
