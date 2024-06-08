extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	game_manager.set_slot1_CD(game_manager.get_slot1_CD() *0.75)
	body.displayUpgrade("Cooldown Decreased!", "down")
	queue_free()
