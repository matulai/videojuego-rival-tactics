extends Node

# Para administrar que unidades selecciono cada jugador en la IU
var team_one_units_to_spawn: Array[PackedScene] = []
var team_two_units_to_spawn: Array[PackedScene] = []

# Para administrar las unidades en escena
var player_one_enemies: Array[Node] = []
var player_two_enemies: Array[Node] = []

# Dos setters para setear los ambos bandos en el main
func set_player_one_enemies(enemies: Array[Node]) -> void:
	player_one_enemies = enemies

func set_player_two_enemies(enemies: Array[Node]) -> void:
	player_two_enemies = enemies

func add_unit_to_army_one(unit: Node) -> void:
	player_two_enemies.append(unit)

func add_unit_to_army_two(unit: Node) -> void:
	player_one_enemies.append(unit)

# Usado en la IU de seleccion de unidades
# Dos setters para setear las unidades que pueden spawnear de cada bando
func set_player_one_units_to_spawn(units: Array[Node]) -> void:
	player_one_enemies = units

func set_player_two_units_to_spawn(units: Array[Node]) -> void:
	player_two_enemies = units

# Utilizado para buscar el mas cercano
func get_unit_enemies(isTeamOne: bool) -> Array[Node]:
	if isTeamOne:
		return player_one_enemies
	else:
		return player_two_enemies

# Para eliminar una unidad del array antes de eliminarlo de memoria
func erase_unit_from_an_army(unit: Node, isTeamOne: bool) -> void:
	if isTeamOne:
		player_two_enemies.erase(unit)
	else:
		player_one_enemies.erase(unit)
