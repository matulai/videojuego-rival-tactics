extends AbstractState

func enter() -> void:
	character.collision_layer = 0
	GLOBAL.erase_unit_from_an_army(character, character.isTeamOne)
	character.death_sound()
	character._play_animation("death_animation")

func _on_animation_finished(anim_name:String) -> void:
	character.remove()
