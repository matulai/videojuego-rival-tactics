extends PanelContainer

@onready var input: Button = $HBoxContainer/Input
@onready var action: Label = $HBoxContainer/Action

@export var action_input: String : set = _set_action_input
@export var action_name: String : set = _set_action_name

func _ready() -> void:
	set_process_input(false)
	input.text = action_input
	action.text = action_name

func _set_action_name(actionN: String) -> void:
	action_name = actionN
	if Engine.is_editor_hint() && has_node("HBoxContainer/Action"):
		$HBoxContainer/Action.text = actionN

func _set_action_input(actionI: String) -> void:
	action_input = actionI
	if Engine.is_editor_hint() && has_node("HBoxContainer/Input"):
		$HBoxContainer/Input.text = actionI

func _on_button_pressed():
	input.text = "..."
	set_process_input(true)

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		# Reasignar la tecla a la acción
		InputMap.action_erase_events(action_name) # Borrar eventos anteriores
		InputMap.action_add_event(action_name, event) # Añadir el nuevo
		input.text = event.as_text() # Mostrar la tecla
		set_process_input(false) # Dejar de capturar eventos
