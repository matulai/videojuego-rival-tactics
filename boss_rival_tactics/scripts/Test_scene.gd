extends Node

# Nodos de unidades de cada bando
@onready var player_one_army = get_node("PlayerOneArmyNode")
@onready var player_two_army = get_node("PlayerTwoArmyNode")

func _ready() -> void:
	# Obtener los enemigos (tropas) de cada bando
	var player_one_enemies = player_two_army.get_children()
	var player_two_enemies = player_one_army.get_children()

	# Setear los enemigos en el autoload
	GLOBAL.set_player_one_enemies(player_one_enemies)
	GLOBAL.set_player_two_enemies(player_two_enemies)
	
