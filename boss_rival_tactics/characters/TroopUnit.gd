extends Character
class_name TroopUnit

@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
@onready var path_timer: Timer = get_node("PathTimer")

#Establezco de donde ir a buscar los enemigos para el NavigationAgent2D
@onready var enemiesNodes: Array[Node] = get_node("../../PlayerOneArmyNode").get_children()
@onready var player: Node = get_node("../../PlayerOneArmyNode/Player")

func chase() -> void:
	var vector_to_next_point: Vector2 = navigation_agent.get_next_path_position() - global_position
	move_direction = vector_to_next_point

func _get_path_to_player() -> void:
	navigation_agent.target_position = player.position

func _on_path_timer_timeout() -> void:
	print("player")
#	Verifico si el player esta en memoria, si no esta es que fue eliminado y busco otro.
	if is_instance_valid(player):
		_get_path_to_player()
		chase()
	else:
		path_timer.stop()
		move_direction = Vector2.ZERO

#func _get_path_to_enemy() -> void:
##	PENSAR EN COMO MEJORAR LA ELECCION DE ENEMIGOS AL INICIO Y LUEGO CUANDO MUERE.
	#navigation_agent.target_position = enemiesNodes[0].position
