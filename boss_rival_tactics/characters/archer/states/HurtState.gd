extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	if (character.hp <= 0):
		emit_signal("finished", "death")
	else:
		character.hurt_sound()
		character._play_animation("hurt_animation")

func update(delta: float) -> void:
	if (character.hp <= 0):
		emit_signal("finished", "death")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "hurt_animation":
		emit_signal("finished", "chase")
