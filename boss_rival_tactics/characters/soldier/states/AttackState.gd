extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	character._play_animation("attack_animation")

func update(_delta: float) -> void:
	character.chase()
	if is_instance_valid(character.target) and character.is_target_reached():
		#print(character.navigation_agent.is_target_reached())
		character._play_animation("attack_animation")
	else:
		emit_signal("finished", "chase")

func _on_animation_finished(anim_name: String) -> void:
	if is_instance_valid(character.target) and anim_name == "attack_animation":
		character.target.take_damage(
			character.damage, 
			character.knockback_direction, 
			character.knockback_force
		)
	

func _on_soldier_character_hurt() -> void:
	emit_signal("finished", "hurt")
