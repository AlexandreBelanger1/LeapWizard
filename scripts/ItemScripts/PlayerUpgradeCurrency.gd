extends Node2D
@onready var game_manager = $".."


func _on_area_2d_body_entered(body):
	game_manager.set_player_upgrade_currency(game_manager.get_player_upgrade_currency()+1)
	game_manager.save_game()
	queue_free()
