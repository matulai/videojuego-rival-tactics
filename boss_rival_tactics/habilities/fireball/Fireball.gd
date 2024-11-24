extends "res://weapons/Proyectile.gd"

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var is_exploting: bool = false

func _ready():
	lifetime_timer.start()
	collision_mask = collision
	animation.play("idle")

func _on_hitbox_body_entered(body: Node2D) -> void:
	animation.play("explosion")
	set_physics_process(false)
	if body.has_method("take_damage"):
		body.take_damage(damage, 0, 0)

func _on_lifetime_timer_timeout() -> void:
	animation.play("explosion")
	set_physics_process(false)
