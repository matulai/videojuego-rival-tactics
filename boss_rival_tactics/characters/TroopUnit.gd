extends Character
class_name TroopUnit

@onready var path_timer: Timer = get_node("PathTimer")
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")

@export var damage: int = 1
@export var knockback_force: int = 300
@export var knockback_direction: Vector2 = Vector2.ZERO
@export var distance_maximun: int

var target: PhysicsBody2D = null

func chase() -> void:
	var vector_to_next_point: Vector2 = navigation_agent.get_next_path_position() - global_position
	move_direction = vector_to_next_point

func _get_path_to_enemy() ->void:
	if is_instance_valid(target):
		navigation_agent.target_position = target.position

func get_closest_node(nodes: Array) -> Node:
	var closest_node: Node = null
	var min_distance: float = INF
	
	for node in nodes:
		if node and node is Node2D:  # Me aseguro de que el nodo es un Node2D
			var distance = global_position.distance_to(node.global_position)
			if distance < min_distance:
				min_distance = distance
				closest_node = node
	return closest_node

func is_target_reached() -> bool:
	return navigation_agent.distance_to_target() < (navigation_agent.get_target_desired_distance() + distance_maximun)

func set_default_max_distance_to_taget() -> void:
	navigation_agent.set_target_desired_distance(10 + distance_maximun)

func set_max_distance_to_target_on(n: int) -> void:
	navigation_agent.set_target_desired_distance(n)

func _on_path_timer_timeout() -> void:
	#print("target_found")
	if is_instance_valid(target):
		target = get_closest_node(GLOBAL.get_unit_enemies(isTeamOne))
		_get_path_to_enemy()
	else:
		target = get_closest_node(GLOBAL.get_unit_enemies(isTeamOne))
