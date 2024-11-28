extends CharacterBody2D
class_name Character

signal character_hurt()

@export var isTeamOne: bool
@export var speed: int = 200
@export var max_hp : int
@export var hp: int: set = set_hp

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var health_bar: ProgressBar = get_node("HealthBar")
@onready var audio_player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

var move_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	set_motion_mode(1)
	if isTeamOne:
		collision_layer = 1
	else:
		collision_layer = 2
	health_bar.init_health(hp, isTeamOne)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func move() -> void:
	move_direction = move_direction.normalized()
	velocity = move_direction * speed
	update_sprite_direction()

func update_sprite_direction() -> void:
	if velocity.x < 0:
		sprite.scale.x = -1
	elif velocity.x > 0:
		sprite.scale.x = 1

func take_damage(amount, dir, force) -> void:
	self.hp -= amount
	health_bar._set_health(self.hp)
	emit_signal("character_hurt")

func remove() -> void:
	queue_free()

func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)

func _play_animation(animation: String) -> void:
	if animation_player.has_animation(animation):
		animation_player.play(animation)

func play_sound(sound_path: String):
	var sound = load(sound_path) as AudioStream
	if sound:
		audio_player.stream = sound
		audio_player.play()

func attack_melee_sound():
	play_sound("res://music_sonds/sword-sound.wav")

func hurt_sound():
	play_sound("res://music_sonds/male-hurt-sound.wav")

func death_sound():
	play_sound("res://music_sonds/man-death-scream.wav")
