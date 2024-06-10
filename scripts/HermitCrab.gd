extends CharacterBody2D

var speed = 60
var moving = false
var attackOnce = false

var RNG = RandomNumberGenerator.new()
func _physics_process(delta):
	if moving:
		if rotation == 90:
			leftWallMovement()
		elif rotation == -90:
			rightWallMovement()
		elif rotation == 180:
			upsideDownMovement()
		move_and_slide()
	


func leftWallMovement():
	pass

func rightWallMovement():
	pass

func upsideDownMovement():
	pass

func attack():
	pass

func _on_attack_or_move_timeout():
	if moving:
		speed = 0
		moving = false
		attackOnce = true
	else:
		moving = true
		speed = 60


func _on_attack_animation_timer_timeout():
	pass # Replace with function body.
