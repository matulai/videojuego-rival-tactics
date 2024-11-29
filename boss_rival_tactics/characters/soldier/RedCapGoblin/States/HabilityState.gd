extends AbstractState

@onready var timer: Timer = $HabilityCoolDown

func enter() -> void:
	print("hability_state")
	if timer.is_stopped():
		character._play_animation("hability_animation")
	else:
		emit_signal("finished", "chase")

func _on_animation_finished(anim_name: String):
	if anim_name == "hability_animation":
		timer.start()
		emit_signal("finished", "chase")
