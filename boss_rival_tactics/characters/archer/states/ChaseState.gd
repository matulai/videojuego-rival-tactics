extends AbstractState

func enter() -> void:
	character._play_animation("walk_animation")

func update(delta: float) -> void:
	if is_instance_valid(character.target):
		character.chase()
		character.move()
		if character.navigation_agent.is_target_reached():
			emit_signal("finished", "attack")
	else:
		emit_signal("finished", "idle")

func _on_archer_character_hurt() -> void:
	emit_signal("finished", "hurt")
