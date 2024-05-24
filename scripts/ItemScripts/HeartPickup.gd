extends Node2D
@onready var game_manager = $".."

var restoration = 2
func _on_area_2d_body_entered(_body):
	var currentHP =game_manager.get_player_HP()
	var maxHP = game_manager.get_player_maxHP()
	if currentHP < maxHP:
		if currentHP + restoration > maxHP:
			game_manager.changeHealth(maxHP-currentHP)
			queue_free()
		else:
			game_manager.changeHealth(restoration)
			queue_free()
		
