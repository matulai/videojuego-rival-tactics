extends Area2D

@onready var lifetime_timer: Timer = $LifetimeTimer

@export var VELOCITY: float = 0

var direction: Vector2
var damage: int
var collision: int

func initialize(initial_position: Vector2, dir: Vector2, speed: int, dam: int, angle: float, isTeamOne: bool) -> void:
	position = initial_position
	rotation += angle
	damage = dam
	direction = dir
	VELOCITY = speed
#	Los del teamOne detectan colision con layer 2 y viceversa.
	collision = 2 if isTeamOne else 1

func _ready() -> void:
	lifetime_timer.start()
	collision_mask = collision

func _physics_process(delta: float) -> void:
	position += direction * VELOCITY * delta

func remove() -> void:
	collision_mask = 0
	queue_free()
	
func _on_lifetime_timer_timeout() -> void:
	remove()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, 0, 0)
	remove()
