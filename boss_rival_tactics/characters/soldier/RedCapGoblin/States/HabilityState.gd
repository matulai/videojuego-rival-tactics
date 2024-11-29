extends AbstractState

func enter() -> void:
	character._play_animation("hability_animation")

func _on_animation_finished(anim_name: String):
	if anim_name == "hability_animation":
		emit_signal("finished", "chase")
