extends Character

@export var is_player_one: bool
@export var damage: int

@onready var hitbox: Area2D = $Hitbox
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var slash_sprite_node: Node2D = $Node2D

func handle_input() -> void:
	if is_player_one:
		move_direction = Input.get_vector("move_left_1", "move_right_1", "move_up_1", "move_down_1")
		if move_direction:
			slash_sprite_node.rotation = move_direction.angle()
			hitbox.rotation = move_direction.angle()
		if Input.is_action_just_pressed("attack_1"):
			attack()
	else :
		move_direction = Input.get_vector("move_left_2", "move_right_2", "move_up_2", "move_down_2")
		if move_direction:
			slash_sprite_node.rotation = move_direction.angle()
			hitbox.rotation = move_direction.angle()
		if Input.is_action_just_pressed("attack_2"):
			attack()

func attack() -> void:
	if attack_cooldown.is_stopped():
		attack_cooldown.start()
		_play_animation("attack_animation")

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and (body.isTeamOne != isTeamOne):
		body.take_damage(damage, 0, 0)
