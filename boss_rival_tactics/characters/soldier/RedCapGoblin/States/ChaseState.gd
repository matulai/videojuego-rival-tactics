extends AbstractState

func enter() -> void:
	print("chase_state")
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
				print("can_make")
				emit_signal("finished", "hability")
		else:
			emit_signal("finished", "attack")
	else:
		emit_signal("finished", "idle")

func can_make_hability() -> bool:
	print(character.distance_for_hability_min < character.navigation_agent.distance_to_target())
	print(character.distance_for_hability_max > character.navigation_agent.distance_to_target())
	print("....")
	return ((character.distance_for_hability_min < character.navigation_agent.distance_to_target()) and (character.distance_for_hability_max > character.navigation_agent.distance_to_target()))

func _on_soldier_character_hurt() -> void:
	emit_signal("finished", "hurt")
