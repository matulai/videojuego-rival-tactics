extends Node

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

# Musica de fondo
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var spawn_timer = 0.0

func _ready() -> void:
#	Pongo a reproducir la musica de fondo
	audio_stream_player.play()
	
	# Obtener los enemigos (tropas) de cada bando
	var player_one_enemies = player_two_army.get_children()
	var player_two_enemies = player_one_army.get_children()

	# Setear los enemigos en el autoload
	GLOBAL.set_player_one_enemies(player_one_enemies)
	GLOBAL.set_player_two_enemies(player_two_enemies)
	
	spawn_players()

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
		var random_scene = unit_scenes_left[randi() % unit_scenes_left.size()]
		var unit = random_scene.instantiate()
		unit.position = left_top_spawn_position.position if randi() % 2 == 0 else left_bottom_spawn_position.position
		unit.isTeamOne = true
		GLOBAL.add_unit_to_army_one(unit)
		player_one_army.add_child(unit)
	elif side == "right":
		# Elegir una escena de unidad aleatoria
		var random_scene = unit_scenes_right[randi() % unit_scenes_right.size()]
		var unit = random_scene.instantiate()
		unit.position = right_top_spawn_position.position if randi() % 2 == 0 else right_bottom_spawn_position.position
		unit.isTeamOne = false
		GLOBAL.add_unit_to_army_two(unit)
		player_two_army.add_child(unit)

func spawn_players() -> void:
	# Instanciar el jugador uno y establecer su posición
	if should_spawn_players:
		var player_one = player_one_scene.instantiate()
		player_one.position = player_one_spawn.position
		player_one.is_player_one = true
		player_one.isTeamOne = true
#		temporal
		player_one.damage = 1
#
		player_one_army.add_child(player_one)
		GLOBAL.add_unit_to_army_one(player_one)

		# Instanciar el jugador dos y establecer su posición
		var player_two = player_two_scene.instantiate()
		player_two.position = player_two_spawn.position
		player_two.is_player_one = false
		player_two.isTeamOne = false
#		temporal
		player_two.damage = 1
#
		player_two_army.add_child(player_two)
		GLOBAL.add_unit_to_army_two(player_two)
