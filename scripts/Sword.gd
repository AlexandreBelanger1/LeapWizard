extends Node2D
@onready var animation_player = $AnimationPlayer

var Lifetime = 3
func _process(delta):
	Lifetime -=delta
	if(Lifetime <= 0):
		queue_free()

func reverseSpin():
	animation_player.speed_scale = -1
