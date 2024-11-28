extends AbstractState

@onready var attack_cooldown: Timer = $AttackCoolDown

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()

func update(delta: float) -> void:
	if is_instance_valid(character.target):
		character.chase()
		if not character.is_target_reached():
			emit_signal("finished", "chase")
		elif attack_cooldown.is_stopped():
			character._play_animation("shoot_animation")
	else:
		emit_signal("finished", "idle")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "shoot_animation":
		attack_cooldown.start()

func _on_archer_character_hurt() -> void:
	emit_signal("finished", "hurt")
