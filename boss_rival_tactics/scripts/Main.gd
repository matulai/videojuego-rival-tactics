extends Node

# Senales
signal game_end(is_team_one: bool)

# Nodos de unidades de cada bando
@onready var player_one_army = get_node("PlayerOneArmyNode")
@onready var player_two_army = get_node("PlayerTwoArmyNode")

# Lista de escenas de unidades
@export var unit_scenes_left: Array[PackedScene]
@export var unit_scenes_right: Array[PackedScene]

# Tiempo en segundos entre unidades
@export var spawn_interval: float = 5.0

# Jugadores
@export var player_one_scene: PackedScene
@export var player_two_scene: PackedScene

# Variable para spawnear o no a los jugadores
@export var should_spawn_players: bool = false

# Lugares donde apareceran las unidades
@onready var right_top_spawn_position: Marker2D = $UnitsSpawner/RightTop
@onready var right_bottom_spawn_position: Marker2D = $UnitsSpawner/RightBottom
@onready var left_top_spawn_position: Marker2D = $UnitsSpawner/LeftTop
@onready var left_bottom_spawn_position: Marker2D = $UnitsSpawner/LeftBottom

# Lugares donde apareceran los jugadores
@onready var player_one_spawn: Marker2D = $PlayersSpawner/PlayerOneSpawn
@onready var player_two_spawn: Marker2D = $PlayersSpawner/PlayerTwoSpawn

#Lugar donde apareceran los refuerzos
@onready var player_one_reinforcements: Marker2D = $ReinforcementsSpawns/PlayerOneReinforcements
@onready var player_two_reinforcements: Marker2D = $ReinforcementsSpawns/PlayerTwoReinforcements

#Temportizadores para respawns de jugadores al morir
@onready var timer_bar_player_one: ProgressBar = $GUI/TimerBarPlayerOne
@onready var timer_bar_player_two: ProgressBar = $GUI/TimerBarPlayerTwo

var spawn_timer = 0.0

func _ready() -> void:
	get_tree().paused = false
	# Obtener los enemigos (tropas) de cada bando
	var player_one_enemies = player_two_army.get_children()
	var player_two_enemies = player_one_army.get_children()

	# Setear los enemigos en el autoload
	GLOBAL.set_player_one_enemies(player_one_enemies)
	GLOBAL.set_player_two_enemies(player_two_enemies)
	
	spawn_players()
	if should_spawn_players:
		$AudioStreamPlayer2D.play()

func _process(delta):
	# Incrementar el temporizador
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_unit("left")
		spawn_unit("right")

func spawn_unit(side: String) -> void:
	# Elegir posición aleatoria de spawn para el lado especificado
	if side == "left":
		# Elegir una escena de unidad aleatoria
		var unit: PhysicsBody2D = instantiate_random_unit_from("left")
		unit.position = left_top_spawn_position.position if randi() % 2 == 0 else left_bottom_spawn_position.position
		GLOBAL.add_unit_to_army_one(unit)
		player_one_army.add_child(unit)
	elif side == "right":
		# Elegir una escena de unidad aleatoria
		var unit: PhysicsBody2D = instantiate_random_unit_from("right")
		unit.position = right_top_spawn_position.position if randi() % 2 == 0 else right_bottom_spawn_position.position
		GLOBAL.add_unit_to_army_two(unit)
		player_two_army.add_child(unit)

func instantiate_random_unit_from(side: String) -> PhysicsBody2D:
	var random_scene: PackedScene
	var unit: PhysicsBody2D
	if side == "left":
		random_scene = unit_scenes_left[randi() % unit_scenes_left.size()]
		unit = random_scene.instantiate()
		unit.isTeamOne = true
	elif side == "right":
		random_scene = unit_scenes_left[randi() % unit_scenes_left.size()]
		unit = random_scene.instantiate()
		unit.isTeamOne = false
	return unit

func instantiate_reinforcements_from(side: String, cant: int) -> void:
	var position_offset = Vector2(0,-5)
	for i in range(cant):
		var unit = instantiate_random_unit_from(side)
		if side == "left":
			unit.position = player_one_reinforcements.position + position_offset
			GLOBAL.add_unit_to_army_one(unit)
			player_one_army.add_child(unit)
		elif side == "right":
			unit.position = player_two_reinforcements.position + position_offset
			GLOBAL.add_unit_to_army_two(unit)
			player_two_army.add_child(unit)
	print("reinforcements_intantiated")

func spawn_players() -> void:
	# Instanciar el jugador uno y establecer su posición
	if should_spawn_players:
		player_one_intiantiate()
		player_two_intiantiate()

func player_one_intiantiate() -> void:
	var player_one = player_one_scene.instantiate()
	player_one.position = player_one_spawn.position
	player_one.is_player_one = true
	player_one.isTeamOne = true
	player_one_army.add_child(player_one)
	GLOBAL.add_unit_to_army_one(player_one)

	player_one.connect("death_player", Callable(self, "_on_player_death"))

func player_two_intiantiate() -> void:
	var player_two = player_two_scene.instantiate()
	player_two.position = player_two_spawn.position
	player_two.is_player_one = false
	player_two.isTeamOne = false

	player_two_army.add_child(player_two)
	GLOBAL.add_unit_to_army_two(player_two)

	player_two.connect("death_player", Callable(self, "_on_player_death"))

func _on_player_death(is_player_one: bool) -> void:
	if is_player_one:
		timer_bar_player_one.start()
	else:
		timer_bar_player_two.start()

func _on_player_one_timer_timeout() -> void:
	player_one_intiantiate()

func _on_player_two_timer_timeout() -> void:
	player_two_intiantiate()

func _on_castle_castle_destroyed(is_team_one: bool) -> void:
	emit_signal("game_end", is_team_one)
	get_tree().paused = true

func _on_castle_castle_reinforcement_request(is_team_one: bool) -> void:
	print("request_recieved", is_team_one)
	instantiate_reinforcements_from("left" if is_team_one else "right", 5)
