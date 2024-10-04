extends AbstractState

func update(delta: float) -> void:
		character.chase()
		character.move()
		if is_instance_valid(character.target):
			if character.navigation_agent.is_target_reached():
				character._play_animation("attack_animation")
		else:
			emit_signal("finished", "idle")


func _on_animation_finished(anim_name: String) -> void:
	if character.navigation_agent.is_target_reached():
		character.target.take_damage(
			character.damage, 
			character.knockback_direction, 
			character.knockback_force
		)
