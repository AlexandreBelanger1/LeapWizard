extends Node2D
@onready var game_manager = $".."

var restoration = 100
func _on_area_2d_body_entered(_body):
	var currentMana =game_manager.get_player_mana()
	var maxMana = game_manager.get_player_max_mana()
	if currentMana < maxMana:
		if currentMana + restoration > maxMana:
			game_manager.add_player_mana(maxMana-currentMana)
			queue_free()
		else:
			game_manager.add_player_mana(restoration)
			queue_free()
