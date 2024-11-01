extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	#if GLOBAL.get_unit_enemies(character.isTeamOne).is_empty():
		#character.path_timer.stop()

func update(_delta: float ) -> void:
	if not GLOBAL.get_unit_enemies(character.isTeamOne).is_empty():
		emit_signal("finished", "chase")
