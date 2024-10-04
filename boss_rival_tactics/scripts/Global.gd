extends Node

var player_one_enemies: Array[Node] = []
var player_two_enemies: Array[Node] = []

func set_player_one_enemies(enemies: Array[Node]) -> void:
	player_one_enemies = enemies

func set_player_two_enemies(enemies: Array[Node]) -> void:
	player_two_enemies = enemies

func get_unit_enemies(isTeamOne: bool) -> Array[Node]:
	if isTeamOne:
		return player_one_enemies
	else:
		return player_two_enemies

func erase_unit_from_an_army(unit: Node, isTeamOne: bool) -> void:
	if isTeamOne:
		player_two_enemies.erase(unit)
	else:
		player_one_enemies.erase(unit)
