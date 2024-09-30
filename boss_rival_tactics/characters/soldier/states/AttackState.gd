extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()

#func update() -> void:
	
