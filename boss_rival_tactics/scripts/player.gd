extends CharacterBody2D
class_name Player

@export var speed : int = 250
@export var max_hp : int = 5
@export var damage : int = 1

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var body_sprite: Sprite2D = $Sprite2D
@onready var hp: int = max_hp
@onready var collision_shape_2d: CollisionShape2D = $Sprite2D/HitBox/CollisionShape2D

var is_attacking : bool = false

func _physics_process(_delta: float) -> void:
	handle_input()
	move_and_slide()

func handle_input() -> void:
	var move_direction : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction * speed
	if (Input.is_action_just_pressed("Attack")):
		handle_body_sprite_direction(move_direction)
		is_attacking = true
		enable_hit_box()
		attack_cooldown.start()

func enable_hit_box() -> void:
	collision_shape_2d.disabled = false

func disable_hit_box() -> void:
	collision_shape_2d.disabled = true

func take_damage(amount, dir, force) -> void:
	hp -= amount
	if (hp > 0):
		velocity += dir * force
	else:
		remove()

func remove() -> void:
	queue_free()

func handle_body_sprite_direction(move_direction: Vector2) -> void:
	if move_direction.x != 0:
		body_sprite.scale.x = move_direction.x
	body_sprite.rotation_degrees = 90 * move_direction.y

func _on_hit_box_body_entered(body: Node2D) -> void:
	if not (body is Player) && is_attacking:
		print("Do attack")
		body.take_damage(damage, Vector2(2,2), 10)

func _on_attack_cooldown_timeout() -> void:
	is_attacking = false
	disable_hit_box()
