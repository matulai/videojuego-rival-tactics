extends AbstractState

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	character._play_animation("hability_animation")

func _on_animation_finished(anim_name: String):
	if anim_name == "hability_animation":
		emit_signal("finished", "idle")
