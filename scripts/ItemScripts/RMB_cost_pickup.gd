extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	game_manager.set_slot2_cost(game_manager.get_slot2_cost() *0.75)
	body.displayUpgrade("Cost", "down")
	queue_free()
