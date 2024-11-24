extends Character

@export var is_player_one: bool
@export var damage: int

@onready var hitbox: Area2D = $Hitbox

signal death_player(is_player_one: bool)

var player_inputs: Dictionary = {
	1: {
		"move_left": "move_left_1",
		"move_right": "move_right_1",
		"move_up": "move_up_1",
		"move_down": "move_down_1",
		"attack": "attack_1",
		"hability": "hability_1"
	},
	2: {
		"move_left": "move_left_2",
		"move_right": "move_right_2",
		"move_up": "move_up_2",
		"move_down": "move_down_2",
		"attack": "attack_2",
		"hability": "hability_2"
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
