extends Node2D
@onready var game_manager = $".."

func _on_area_2d_body_entered(_body):
	game_manager.set_slot2_damage(game_manager.get_slot2_damage() *1.25)
	queue_free()
