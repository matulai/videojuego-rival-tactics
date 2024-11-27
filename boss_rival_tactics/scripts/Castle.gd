extends StaticBody2D

signal castle_destroyed(is_team_one: bool)

@export var isTeamOne: bool
@export var hp: int

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var health_bar: ProgressBar = get_node("HealthBar")
@onready var audio_player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

func _ready() -> void:
	if isTeamOne:
		collision_layer = 1
	else:
		collision_layer = 2
	health_bar.init_health(hp, isTeamOne)

func take_damage(amount, dir, force) -> void:
	self.hp -= amount
	health_bar._set_health(self.hp)
	if hp <= 0:
		animated_sprite.play("start_burning")
		while animated_sprite.is_playing():
			pass
		animated_sprite.play("burning")
