extends TroopUnit

@onready var arrow_spawn: Marker2D = $Sprite2D/ArrowSpawn

@export var projectile_scene: PackedScene

func fire() -> void:
	if not is_instance_valid(target):
		return
	play_sound("res://music_sonds/bow-shoot-sound.wav")
	var projectile_instance = projectile_scene.instantiate()
	
	var target_position = target.global_position
	var angle_to_target = arrow_spawn.global_position.angle_to_point(target_position)
	var direction = Vector2(cos(angle_to_target), sin(angle_to_target))

	projectile_instance.initialize(
		arrow_spawn.global_position, 
		direction,
		700.0, 
		angle_to_target,
		isTeamOne
	)

	get_tree().current_scene.add_child(projectile_instance)
