extends AbstractState

func enter() -> void:
	character._play_animation("walk_animation")

func update(delta: float) -> void:
	if is_instance_valid(character.target):
		if character.target is StaticBody2D:
			character.set_max_distance_to_target_on(48)
		else:
			character.set_default_max_distance_to_taget()
		character.chase()
		character.move()
		if character.navigation_agent.is_target_reached():
			emit_signal("finished", "attack")
	else:
		emit_signal("finished", "idle")

func _on_soldier_character_hurt() -> void:
	emit_signal("finished", "hurt")
