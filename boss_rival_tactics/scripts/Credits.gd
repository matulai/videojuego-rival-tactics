extends Control

signal returnToMainMenu()

func _on_return_button_pressed() -> void:
	visible = false
	emit_signal("returnToMainMenu")
