extends StaticBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var laser_timer = $LaserTimer
@onready var shoot_timer = $ShootTimer

const LASER_BEAM = preload("res://scenes/laser_beam.tscn")
var RNG = RandomNumberGenerator.new()

var pause = true
var isPaused = true

func pauseTurret(value: bool):
	pause = value
	if pause:
		animated_sprite_2d.play("Closed")
		laser_timer.stop()
	elif !pause:
		animated_sprite_2d.play("Open")


#func _on_shoot_timer_timeout():
#	animated_sprite_2d.play("Open")



func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "Open":
		shoot()
	elif animated_sprite_2d.animation == "Close":
		animated_sprite_2d.play("Closed")



func shoot():
	if rotation >-0.5 and rotation <0.5:
		for i in 22:
			var laser = LASER_BEAM.instantiate()
			add_child(laser)
			laser.global_position.y = global_position.y
			laser.global_position.x = global_position.x - i*16
	if rotation >3 and rotation <3.5:
		for i in 22:
			var laser = LASER_BEAM.instantiate()
			add_child(laser)
			laser.global_position.y = global_position.y
			laser.global_position.x = global_position.x + i*16
	if rotation > -2 and rotation < -1:
		for i in 15:
			var laser = LASER_BEAM.instantiate()
			add_child(laser)
			laser.global_position.y = global_position.y + i*16
			laser.global_position.x = global_position.x 
	laser_timer.start(5.2)

func _on_laser_timer_timeout():
	animated_sprite_2d.play("Close")
	

func takeLMBDamage():
	pass

func takeRMBDamage():
	pass

func _on_animated_sprite_2d_animation_looped():
	pass
