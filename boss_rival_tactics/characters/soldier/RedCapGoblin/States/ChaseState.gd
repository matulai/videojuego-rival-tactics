extends AbstractState

func enter() -> void:
	character.set_max_distance_to_target_on(72)
	character._play_animation("walk_animation")

func update(delta: float) -> void:
	if is_instance_valid(character.target):
		if character.target is StaticBody2D:
			character.set_max_distance_to_target_on(48)
		else:
			character.set_default_max_distance_to_taget()
		
		character.chase()
		character.move()
		if not character.navigation_agent.is_target_reached():
			if can_make_hability():
				emit_signal("finished", "hability")
		else:
			emit_signal("finished", "attack")
	else:
		emit_signal("finished", "idle")

func can_make_hability() -> bool:
	return character.distance_for_hability < character.navigation_agent.distance_to_target()

func _on_soldier_character_hurt() -> void:
	emit_signal("finished", "hurt")
