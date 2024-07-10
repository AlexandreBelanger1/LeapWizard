extends Control

@onready var label = $Label
@onready var game_manager = $"../.."



func _on_setup_timer_timeout():
	label.text = "LEAP " + str(game_manager.get_world_number() + 1)

