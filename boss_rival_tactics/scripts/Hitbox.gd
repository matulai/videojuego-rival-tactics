extends Area2D
class_name Hitbox

@export var damage: int = 1
@export var knockback_force: int = 300
var knockback_direction: Vector2 = Vector2.ZERO

var body_inside: bool = false

@onready var timer: Timer = Timer.new()
@onready var collision_shape: CollisionShape2D = get_child(0)
@onready var unit: TroopUnit = get_parent()

func _init() -> void:
	var __ = connect("body_entered", Callable(self, "_on_body_entered"))
	__ = connect("body_exited", Callable(self, "_on_body_exited"))

func _ready() -> void:
	assert(collision_shape != null)
	collision_shape.set_disabled(true)
	timer.wait_time = 1
	add_child(timer)

func _on_body_entered(body: Node2D) -> void:
	print("body_entered")
	body_inside = true
	timer.start()
	while body_inside:
		_collide(body)
		await timer.timeout

func _on_body_exited(body: Node2D) -> void:	
	print("body_exited")
	body_inside = false
	timer.stop()
	unit.isAttacking = false

func _collide(body: Node2D) -> void:
	if body == null or not body.has_method("take_damage"):
		print("Null_o_no_take_damage")
		queue_free()
	elif body is Player:
		print("player attacked")
		body.take_damage(damage, knockback_direction, knockback_force)
