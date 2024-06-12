extends CharacterBody2D
@onready var game_manager = $"../.."
@onready var attack_animation_timer = $AttackAnimationTimer
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var sprite = $Sprite
@onready var health_bar = $HealthBar
@onready var damaged_sound = $DamagedSound
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")

const BOSS_ATTACK = preload("res://scenes/boss_attack.tscn")

var speed = 60
var moving = true
var dir = Vector2(0,0)
var RNG = RandomNumberGenerator.new()
var rand
var Damaged = false
var DamagedTimer = 0
var difficulty = 0
var HP = 350 

func _ready():
	rand = RNG.randf_range(0,2)

func _physics_process(delta):
	if moving:
		if rotation_degrees > 75 and rotation_degrees < 105:
			leftWallMovement()
		elif rotation_degrees > -105 and rotation_degrees < -75:
			rightWallMovement()
		elif rotation_degrees > 165 and rotation_degrees < 195:
			upsideDownMovement()
		
		velocity = dir * speed
		move_and_slide()

func leftWallMovement():
	if rand > 1 :
		#If no collision upwards, move upwards
		if !ray_cast_left.is_colliding():
			dir = Vector2(0,-1)
		#Otherwise, move downwards
		else:
			rand  = 0
			dir = Vector2(0,1)
	elif rand <= 1 :
		#If no collision downwards, move downwards
		if !ray_cast_right.is_colliding():
			dir = Vector2(0,1)
		#Otherwise, move upwards
		else:
			rand  = 2
			dir = Vector2(0,-1)
	if ray_cast_left.is_colliding()  and ray_cast_right.is_colliding():
		dir = Vector2(0,0)

func rightWallMovement():
	if rand > 1 :
		#If no collision upwards, move upwards
		if !ray_cast_right.is_colliding():
			dir = Vector2(0,-1)
		#Otherwise, move downwards
		else:
			rand  = 0
			dir = Vector2(0,1)
	elif rand <= 1 :
		#If no collision downwards, move downwards
		if !ray_cast_left.is_colliding():
			dir = Vector2(0,1)
		#Otherwise, move upwards
		else:
			rand  = 2
			dir = Vector2(0,-1)
	if ray_cast_left.is_colliding()  and ray_cast_right.is_colliding():
		dir = Vector2(0,0)

func upsideDownMovement():
	if rand > 1 :
		#If no collision left, move left
		if !ray_cast_right.is_colliding():
			dir = Vector2(-1,0)
		#Otherwise, move right
		else:
			rand  = 0
			dir = Vector2(1,0)
	elif rand <= 1 :
		#If no collision right, move right
		if !ray_cast_left.is_colliding():
			dir = Vector2(1,0)
		#Otherwise, move left
		else:
			rand  = 2
			dir = Vector2(-1,0)
	if ray_cast_left.is_colliding()  and ray_cast_right.is_colliding():
		dir = Vector2(0,0)

func attack():
	if difficulty == 0:
		for i in 3:
			var attackProjectile = BOSS_ATTACK.instantiate()
			get_parent().add_child(attackProjectile)
			attackProjectile.velocity = Vector2(sin((rotation - (PI/6)) + i*(PI/6)),-cos((rotation - (PI/6)) + i*(PI/6)))
			attackProjectile.global_position = global_position
	elif difficulty == 1:
		for i in 5:
			var attackProjectile = BOSS_ATTACK.instantiate()
			get_parent().add_child(attackProjectile)
			attackProjectile.velocity = Vector2(sin((rotation - (PI/3)) + i*(PI/6)),-cos((rotation - (PI/3)) + i*(PI/6)))
			attackProjectile.global_position = global_position

func _on_attack_or_move_timeout():
	if moving:
		
		#Stop moving
		speed = 0
		moving = false
		
		#Begin attack animation and attack once
		attack_animation_timer.start()
		sprite.animation = "Attack"
	else:
		
		#Select new random direction and begin moving
		rand = RNG.randf_range(0,2)
		moving = true
		speed = 60
		sprite.animation = "Walk"

func _on_attack_animation_timer_timeout():
	attack()
	sprite.animation = "Idle"

func setHPBarPosition():
	health_bar.setPosition(0,global_position.x,global_position.y-18)
	#health_bar.rotation = 0
	#health_bar.global_position.x = global_position.x
	#health_bar.global_position.y = global_position.y-18
func applyDamaged():
	damaged_sound.playing = true
	sprite.modulate = Color(0,0,255)
	Damaged = true
	DamagedTimer = 0

func takeLMBDamage():
	HP -= int(game_manager.get_slot1_total_damage())
	health_bar.loseHP(game_manager.get_slot1_total_damage())
	checkDeath()
	applyDamaged()

func takeRMBDamage():
	HP -= int(game_manager.get_slot2_total_damage())
	health_bar.loseHP(game_manager.get_slot2_total_damage())
	checkDeath()
	applyDamaged()

var dead = false
func checkDeath():
	if HP <= 0 and !dead:
		dead = true
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		#Reward the player
		game_manager.add_point()
		#Delete enemy
		call_deferred("free")
		#queue_free()
