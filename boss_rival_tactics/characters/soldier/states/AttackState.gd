extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	character._play_animation("attack_animation")

func exit() -> void:
	character.collision_shape.set_disabled(true)

func update(_delta: float) -> void:
	if not character.is_attacking:
		emit_signal("finished", "chase")
