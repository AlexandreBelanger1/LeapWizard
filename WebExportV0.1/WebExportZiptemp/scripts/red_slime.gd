extends Node2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 60

var DIRECTION = 1

func _process(delta):
	if ray_cast_right.is_colliding():
		DIRECTION = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		DIRECTION = 1
		animated_sprite_2d.flip_h = false
	position.x += DIRECTION *SPEED * delta
