extends ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition =  get_parent().getPlayerPosition()
	global_position.x = playerPosition.x-93
	global_position.y = playerPosition.y-115
