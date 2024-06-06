extends CharacterBody2D

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var aggro_range = $AggroRange

var target 
var speed = 80
var InPlayerRange = false
var player

func _on_aggro_range_body_entered(body):
	if InPlayerRange:
		if target == null:
			target = body


func makePath() -> void:
	if target != null and InPlayerRange:
		navigation_agent_2d.target_position.x = target.global_position.x
		navigation_agent_2d.target_position.y = target.global_position.y
	elif player != null:
		navigation_agent_2d.target_position.x = player.global_position.x
		navigation_agent_2d.target_position.y = player.global_position.y -10
	else:
		pass

func _on_timer_timeout():
	makePath()

func _on_hitbox_body_entered(body):
	body.takeLMBDamage()

func _physics_process(_delta: float) -> void:
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	if (global_position.distance_to(navigation_agent_2d.get_next_path_position())<1):
		speed = 0
	else:
		speed = 80
	velocity = dir * speed
	if dir.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	move_and_slide()

var cooldown = 0.5
var cooldownTimer = 0
func _process(delta):
	if cooldownTimer < cooldown :
		hitbox.set_collision_mask_value(3,true)
		if target == null and InPlayerRange:
			aggro_range.set_collision_mask_value(3,true)
	elif cooldownTimer  >= cooldown:
		hitbox.set_collision_mask_value(3,false)
		if target == null and InPlayerRange:
			aggro_range.set_collision_mask_value(3,false)
	if cooldownTimer > 2*cooldown:
		cooldownTimer  = 0
	cooldownTimer += delta
	

	

func _on_player_range_body_entered(body):
	player = body
	InPlayerRange = true




func _on_player_range_body_exited(_body):
	InPlayerRange = false


func _on_aggro_range_body_exited(body):
	if target == body:
		target = null


func _on_teleport_2_player_body_exited(body):
	global_position.x = body.global_position.x
	global_position.y = body.global_position.y
