extends Node

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_options_button_pressed() -> void:
	$MenuOptions.visible = false
	$OptionsMenu.visible = true

func _on_credits_pressed() -> void:
	$MenuOptions.visible = false
	$Credits.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_menu_return_to_main_menu() -> void:
	$MenuOptions.visible = true
