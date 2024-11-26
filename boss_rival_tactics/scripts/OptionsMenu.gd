extends Control

signal returnToMainMenu()

func _ready() -> void:
	update_controls()

func _on_return_button_pressed() -> void:
	visible = false
	emit_signal("returnToMainMenu")

func update_controls():
	# Recorrer los hijos de `PlayerOneControls`
	for action in $Panel/VScrollBar/PlayerOneControls.get_children():
			var input_label = action.action_input
			var action_label = action.action_name

			var events = InputMap.action_get_events(action_label)

				# Actualizar el texto del botón según las teclas asignadas
			if events.size() > 0:
				for event in events:
					if event is InputEventKey:
						var clean_text = event.as_text().split(" (")[0]
						action._set_action_input(clean_text)
						break
			else:
				action._set_action_name("No asignado")
