extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	var maxHP = game_manager.get_player_maxHP()
	if maxHP <12:
		body.displayUpgrade("Max HP", "up")
		game_manager.set_player_maxHP(maxHP + 2)
		queue_free()
