extends ProgressBar

signal can_respawn_player

@export var time: int
@export var is_team_one: bool

@onready var timer = $Timer

var elapsed_time = 0.0

func _ready():
	set_team_color(is_team_one)

func start() -> void:
	max_value = time
	value = time
	visible = true
	timer.start()

func _on_timer_timeout() -> void:
	value -= timer.get_wait_time()
	if value == 0:
		emit_signal("can_respawn_player")
	else:
		timer.start()

func set_team_color(is_team_one: bool):
	var fill_style = get_theme_stylebox("fill").duplicate()
	
	if fill_style and fill_style is StyleBoxFlat:
		fill_style.bg_color = Color(0, 0, 1) if is_team_one else Color(1, 0, 0)

	add_theme_stylebox_override("fill", fill_style)
