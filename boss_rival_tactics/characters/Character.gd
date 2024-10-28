extends CharacterBody2D
class_name Character

@export var isTeamOne: bool

@export var speed: int = 200

@export var max_hp : int = 20
@export var hp: int = 2: set = set_hp
#signal hp_changed(new_hp)

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var move_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	set_motion_mode(1)
	if isTeamOne:
		collision_layer = 1
	else:
		collision_layer = 2

func _physics_process(_delta: float) -> void:
	move_and_slide()

func move() -> void:
	move_direction = move_direction.normalized()
	velocity = move_direction * speed

func take_damage(amount, dir, force) -> void:
	self.hp -= amount
	if (hp <= 0):
		remove()

func remove() -> void:
	GLOBAL.erase_unit_from_an_army(self, isTeamOne)
	queue_free()

func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)
	#emit_signal("hp_changed", hp)

func _play_animation(animation: String) -> void:
	if animation_player.has_animation(animation):
		animation_player.play(animation)
