extends Camera2D


@onready var player = $"../Player"

var target = Vector2(-999,-999)
func _process(_delta):
	if target == Vector2(-999,-999):
		set_position(player.get_position())
	else:
		if position.x < target.x:
			position.x += 1
		if position.x > target.x:
			position.y -= 1
		if position.y < target.y:
			position.y += 1
		if position.y > target.y:
			position.y -= 1

func setTarget(value):
	target = value
