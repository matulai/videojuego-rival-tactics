extends AbstractState

func enter() -> void:
	character._play_animation("walk_animation")

func update(delta: float) -> void:
	character.handle_input()
	if character.move_direction == Vector2.ZERO:
		emit_signal("finished", "idle")
	if character.is_attack_pressed():
		emit_signal("finished", "attack")
	character.move()


func _on_player_character_hurt() -> void:
	emit_signal("finished", "hurt")
