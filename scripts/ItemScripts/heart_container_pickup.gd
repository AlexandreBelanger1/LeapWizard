extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	body.displayUpgrade("Max HP", "up")
	var maxHP = game_manager.get_player_maxHP()
	if maxHP <14:
		game_manager.set_player_maxHP(maxHP + 2)
		queue_free()
