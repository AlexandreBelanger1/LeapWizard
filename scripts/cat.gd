extends CharacterBody2D
@onready var player = $"../Player"
@onready var animation = $Animation

var SPEED = 140
var DistanceToPlayer
var targetPosition = global_position
func _process(_delta):
	DistanceToPlayer = sqrt(pow(global_position.y - player.global_position.y,2) + pow(global_position.x - player.global_position.x,2))
	if DistanceToPlayer < 20:
		SPEED = 0
	if DistanceToPlayer > 20 and DistanceToPlayer < 50 :
		SPEED = 50
	if DistanceToPlayer > 50 :
		SPEED = 130
	if global_position.x - player.global_position.x <0:
		animation .flip_h = false
	else:
		animation .flip_h = true
	#targetPosition = player.global_position.x,player.global_position.y
	velocity = (player.global_position -global_position).normalized() *SPEED
	move_and_slide()
