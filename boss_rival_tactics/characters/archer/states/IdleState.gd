extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	character._play_animation("idle_animation")

func update(_delta: float ) -> void:
	if (not GLOBAL.get_unit_enemies(character.isTeamOne).is_empty()) and is_instance_valid(character.target):
		emit_signal("finished", "chase")

func _on_archer_character_hurt() -> void:
	emit_signal("finished", "hurt")
