extends AbstractState

@onready var attack_cooldown: Timer = $AttackCoolDown

var can_attack: bool

func enter() -> void:
	character.move_direction = Vector2.ZERO
	character.move()
	can_attack = true
	attack_cooldown.start()

func update(delta: float) -> void:
	if is_instance_valid(character.target):
		if not character.navigation_agent.is_navigation_finished():
			emit_signal("finished", "chase")

		if can_attack and attack_cooldown.is_stopped():
			character.fire()
			can_attack = false
			attack_cooldown.start()
	else:
		emit_signal("finished", "idle")

func _on_attack_cool_down_timeout() -> void:
	can_attack = true
