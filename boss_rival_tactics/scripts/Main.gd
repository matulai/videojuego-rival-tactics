extends Node

@onready var player_one_army = get_node("PlayerOneArmyNode")
@onready var player_two_army = get_node("PlayerTwoArmyNode")

# Lista de escenas de unidades
@export var unit_scenes_left: Array[PackedScene]
@export var unit_scenes_right: Array[PackedScene]

# Tiempo en segundos entre unidades
@export var spawn_interval: float = 7.0

# Lugares donde apareceran las unidades
@onready var right_top_spawn_position: Marker2D = $UnitsSpawner/RightTop
@onready var right_bottom_spawn_position: Marker2D = $UnitsSpawner/RightBottom
@onready var left_top_spawn_position: Marker2D = $UnitsSpawner/LeftTop
@onready var left_bottom_spawn_position: Marker2D = $UnitsSpawner/LeftBottom

var spawn_timer = 0.0

func _ready() -> void:
	# Obtener los enemigos (tropas) de cada bando
	var player_one_enemies = player_two_army.get_children()
	var player_two_enemies = player_one_army.get_children()

	# Setear los enemigos en el autoload
	GLOBAL.set_player_one_enemies(player_one_enemies)
	GLOBAL.set_player_two_enemies(player_two_enemies)

func _process(delta):
	# Incrementar el temporizador
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_unit("left")
		spawn_unit("right")

func spawn_unit(side: String):
	# Elegir posición aleatoria de spawn para el lado especificado
	if side == "left":
		# Elegir una escena de unidad aleatoria
		var random_scene = unit_scenes_left[randi() % unit_scenes_left.size()]
		var unit = random_scene.instantiate()
		unit.position = left_top_spawn_position.position if randi() % 2 == 0 else left_bottom_spawn_position.position
		unit.isTeamOne = true
		GLOBAL.add_unit_to_army_one(unit)
		add_child(unit)
	elif side == "right":
		# Elegir una escena de unidad aleatoria
		var random_scene = unit_scenes_right[randi() % unit_scenes_right.size()]
		var unit = random_scene.instantiate()
		unit.position = right_top_spawn_position.position if randi() % 2 == 0 else right_bottom_spawn_position.position
		unit.isTeamOne = false
		GLOBAL.add_unit_to_army_two(unit)
		add_child(unit)
