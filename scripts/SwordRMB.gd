extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var sword_swing = $SwordSwing
const SPARKS = preload("res://scenes/sparks.tscn")
func _ready():
	sword_swing.play()

var Lifetime = 0.5
func _process(delta):
	Lifetime -=delta
	if(Lifetime <= 0):
		queue_free()

func reverseSpin():
	animation_player.speed_scale = -1


func _on_hitbox_body_entered(body):
	var sparks = SPARKS.instantiate()
	get_parent().add_child(sparks)
	sparks.global_position = body.global_position
	body.takeRMBDamage()
