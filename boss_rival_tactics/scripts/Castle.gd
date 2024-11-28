extends StaticBody2D

signal castle_destroyed(is_team_one: bool)
signal castle_reinforcement_request(is_team_one: bool)

@export var isTeamOne: bool
@export var hp: int

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var health_bar: ProgressBar = get_node("HealthBar")
@onready var audio_player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
@onready var time_under_attack: Timer = get_node("TimeUnderAttack")

var is_burning: bool = false
var damage_taked: int = 0

func _ready() -> void:
	if isTeamOne:
		collision_layer = 1
	else:
		collision_layer = 2
	health_bar.init_health(hp, isTeamOne)

func take_damage(amount, dir, force) -> void:
	self.hp -= amount
	health_bar._set_health(self.hp)
	if hp <= 0 and not is_burning:
		is_burning = true
		animated_sprite.play("start_burning")
	else:
		under_attack(amount)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.get_animation() == "start_burning":
		GLOBAL.erase_unit_from_an_army(self, isTeamOne)
		emit_signal("castle_destroyed", isTeamOne)
		animated_sprite.play("burning")

func under_attack(damage: int) -> void:
	if not time_under_attack.is_stopped():
		damage_taked += damage
	else:
		time_under_attack.start()
		damage_taked += damage

func _on_time_under_attack_timeout() -> void:
	if damage_taked >= 50:
		emit_signal("castle_reinforcement_request", isTeamOne)
		audio_player.play()
	damage_taked = 0
