extends "res://characters/player/Player.gd"

@onready var spawn: Marker2D = $Sprite2D/Marker2D

@export var projectile_scene: PackedScene

func fire() -> void:
	var projectile_instance = projectile_scene.instantiate()
	
	var angle_to_target = 0 if sprite.scale.x == 1 else -180
	var angle_in_radians = deg_to_rad(angle_to_target)
	var direction = Vector2(cos(angle_in_radians), sin(angle_in_radians))
	projectile_instance.initialize(
		spawn.global_position, 
		direction,
		700.0, 
		angle_in_radians,
		isTeamOne
	)

	get_tree().current_scene.add_child(projectile_instance)

func hability_spell_cast_sound() -> void:
	play_sound("res://music_sonds/magical-spell-cast.wav")
