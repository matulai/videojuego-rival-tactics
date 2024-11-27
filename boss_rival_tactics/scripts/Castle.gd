extends StaticBody2D

signal castle_destroyed(is_team_one: bool)

@export var isTeamOne: bool
@export var hp: int

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var health_bar: ProgressBar = get_node("HealthBar")
@onready var audio_player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

var is_burning: bool = false

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

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.get_animation() == "start_burning":
		GLOBAL.erase_unit_from_an_army(self, isTeamOne)
		emit_signal("castle_destroyed", isTeamOne)
		animated_sprite.play("burning")
