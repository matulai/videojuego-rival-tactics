extends TroopUnit

@onready var arrow_spawn: Marker2D = $ArrowSpawn

@export var projectile_scene: PackedScene

func fire() -> void:
	var projectile_instance = projectile_scene.instantiate()
	
	var angle_to_target = get_angle_to(target.position)
	var direction = Vector2(cos(angle_to_target), sin(angle_to_target))

	projectile_instance.initialize(
		arrow_spawn.global_position, 
		direction,
		700.0, 
		damage,
		angle_to_target,
		collision_mask
	)

	get_tree().current_scene.add_child(projectile_instance)