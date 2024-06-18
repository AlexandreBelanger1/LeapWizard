extends CharacterBody2D

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var aggro_range = $AggroRange
@onready var lifetime = $Lifetime

const BAT_ATTACK = preload("res://scenes/batAttack.tscn")

var target 
var speed = 80
var InPlayerRange = false
var player
var lifetimeValue = 6
var MB = 0

func _ready():
	lifetime.wait_time = lifetimeValue
	lifetime.start()


func setLifetime(value):
	lifetimeValue = value


func _on_aggro_range_body_entered(body):
	if InPlayerRange:
		if target == null:
			target = body
			is_attacking = true


func makePath() -> void:
	if target != null and InPlayerRange:
		navigation_agent_2d.target_position.x = target.global_position.x-32
		navigation_agent_2d.target_position.y = target.global_position.y-16
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
var is_attacking = false
func _process(delta):
	if cooldownTimer >= cooldown :
		if is_attacking:
			attack()
		if target == null and InPlayerRange:
			aggro_range.set_collision_mask_value(3,true)
		cooldownTimer  = 0
	cooldownTimer += delta
	

func attack():
	#attack_sound.play()
	var attackprojectile = BAT_ATTACK.instantiate()
	get_parent().add_child(attackprojectile)
	attackprojectile.global_position.x = global_position.x
	attackprojectile.global_position.y = global_position.y
	attackprojectile.velocity = target.global_position - attackprojectile.global_position
	if(attackprojectile.velocity.x >0):
		attackprojectile.rotate(atan( attackprojectile.velocity.y/attackprojectile.velocity.x)) 
	else:
		attackprojectile.rotate(PI+ atan( attackprojectile.velocity.y/attackprojectile.velocity.x)) 

func _on_player_range_body_entered(body):
	player = body
	InPlayerRange = true




func _on_player_range_body_exited(_body):
	InPlayerRange = false


func _on_aggro_range_body_exited(body):
	if target == body:
		target = null
		is_attacking = false


func _on_teleport_2_player_body_exited(body):
	global_position.x = body.global_position.x
	global_position.y = body.global_position.y

func _on_lifetime_timeout():
	call_deferred("queue_free")

func setMB(value):
	MB = value
