extends CharacterBody2D
class_name Character

@export var speed: int = 200

@export var max_hp : int = 20
@export var hp: int = 2: set = set_hp
#signal hp_changed(new_hp)

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var move_direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move_and_slide()

func move() -> void:
	move_direction = move_direction.normalized()
	velocity = move_direction * speed

######################################################

func take_damage(amount, dir, force) -> void:
	self.hp -= amount
	if (hp > 0):
		velocity += dir * force
	else:
		remove()
		
func remove() -> void:
	queue_free()

func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)
	#emit_signal("hp_changed", hp)
