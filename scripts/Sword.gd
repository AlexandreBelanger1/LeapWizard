extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var sword_swing = $SwordSwing

func _ready():
	sword_swing.play()

var Lifetime = 0.5
func _process(delta):
	Lifetime -=delta
	if(Lifetime <= 0):
		queue_free()

func reverseSpin():
	animation_player.speed_scale = -1
