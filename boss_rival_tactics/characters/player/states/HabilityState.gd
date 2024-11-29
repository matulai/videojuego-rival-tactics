extends AbstractState

func enter() -> void:
	if not character.hability_bar.is_hability_on_cooldown:
		character.move_direction = Vector2.ZERO
		character.move()
		character._play_animation("hability_animation")
	else:
		emit_signal("finished", "idle")

func _on_animation_finished(anim_name: String):
	if anim_name == "hability_animation":
		emit_signal("finished", "idle")
		character.hability_bar.hability_casted()
