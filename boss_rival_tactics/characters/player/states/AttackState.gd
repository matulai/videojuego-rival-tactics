extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	character._play_animation("attack_animation")

func _on_animation_finished(anim_name: String):
	if anim_name == "attack_animation":
		emit_signal("finished", "idle")

func _on_player_character_hurt() -> void:
	emit_signal("finished", "hurt")
