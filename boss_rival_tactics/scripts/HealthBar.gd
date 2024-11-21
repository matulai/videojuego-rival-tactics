extends ProgressBar

var health = 0 : set = _set_health

func _set_health(new_health):
	health = min(max_value, new_health)
	value = health

	if health <= 0:
		visible = false

func init_health(_health: int, is_team_one: bool):
	health = _health
	max_value = health
	value = health
	set_team_color(is_team_one)

func set_team_color(is_team_one: bool):
	# Crea un StyleBoxFlat para el relleno (Fill)
	var fill_style = StyleBoxFlat.new()
	fill_style.bg_color = Color(0, 0, 1) if is_team_one else Color(1, 0, 0)
	add_theme_stylebox_override("fill", fill_style)
