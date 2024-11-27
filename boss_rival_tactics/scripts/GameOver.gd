extends Control

@onready var title: Label = $Panel/Title

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_game_end_(is_team_one: bool) -> void:
	if not is_team_one:
		title.text = "BLUE TEAM 
		WINS"
	else:
		title.text = "RED TEAM
		WINS"
	visible = true
