extends Character

@export var is_player_one: bool
@export var damage: int

@onready var hitbox: Area2D = $Hitbox
@onready var hability_bar: ProgressBar = $HabilityBar

signal death_player(is_player_one: bool)

var player_inputs: Dictionary = {
	1: {
		"move_left": "MOVE_LEFT_1",
		"move_right": "MOVE_RIGHT_1",
		"move_up": "MOVE_UP_1",
		"move_down": "MOVE_DOWN_1",
		"attack": "ATTACK_1",
		"hability": "HABILITY_1"
	},
	2: {
		"move_left": "MOVE_LEFT_2",
		"move_right": "MOVE_RIGHT_2",
		"move_up": "MOVE_UP_2",
		"move_down": "MOVE_DOWN_2",
		"attack": "ATTACK_2",
		"hability": "HABILITY_2"
	}
}

@onready var inputs: Dictionary = player_inputs[1 if is_player_one else 2]

func handle_input() -> void:
	move_direction = Input.get_vector(inputs["move_left"], inputs["move_right"], inputs["move_up"], inputs["move_down"])
	if velocity.x < 0:
		hitbox.scale.x = -1
	elif velocity.x > 0:
		hitbox.scale.x = 1

func is_attack_pressed() -> bool:
	return Input.is_action_just_pressed(inputs["attack"])

func is_hability_pressed() -> bool:
	return Input.is_action_just_pressed(inputs["hability"])

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and (body.isTeamOne != isTeamOne):
		body.take_damage(damage, 0, 0)

func remove() -> void:
	emit_signal("death_player", is_player_one)
	queue_free()
