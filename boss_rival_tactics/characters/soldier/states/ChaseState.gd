extends AbstractState

func update(delta: float) -> void:
	character.chase()
	character.move()

	if is_instance_valid(character.target):
#		Ataco si el enemigo esta cerca, distancia definida en NavigationAgent2D
		if character.navigation_agent.is_target_reached():
			character._play_animation("attack_animation")
	else:
		emit_signal("finished", "idle")


func _on_animation_finished(anim_name: String) -> void:
#CUANDO SE AGREGEN MAS ANIMACIONES CAMBIAR ESTA IMPLEMENTACION
	if character.navigation_agent.is_target_reached():
		character.target.take_damage(
			character.damage, 
			character.knockback_direction, 
			character.knockback_force
		)
