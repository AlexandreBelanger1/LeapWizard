extends Camera2D

@onready var player = %Player

func _process(delta):
	set_position(player.get_position())
