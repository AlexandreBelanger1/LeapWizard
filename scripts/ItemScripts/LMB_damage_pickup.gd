extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(body):
	game_manager.set_slot1_damage(game_manager.get_slot1_damage() *1.25)
	body.displayUpgrade("Damage", "up")
	queue_free()
