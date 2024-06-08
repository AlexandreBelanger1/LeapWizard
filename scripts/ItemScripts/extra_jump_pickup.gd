extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	body.displayUpgrade("+1 Jump", "up")
	game_manager.addJumps(1)
	queue_free()

