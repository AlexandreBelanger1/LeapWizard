extends Camera2D


@onready var player = $"../Player"

func _process(_delta):
	set_position(player.get_position())
