extends Character

func handle_input() -> void:
	move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
