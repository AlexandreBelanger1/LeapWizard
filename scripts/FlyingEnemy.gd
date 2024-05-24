extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var player = $"../../Player"
@onready var attack_sound = $AttackSound
@onready var eye = $EyeShoot/Eye
@onready var health_bar = $HealthBar
@onready var body_animation = $BodyAnimation
@onready var damaged_sound = $DamagedSound

const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")

var HP = 25
const distance = 1
var pointToPlayer = position
const attackPath = preload('res://scenes/boss_attack.tscn')
var cooldownTimer: float
var cooldown = 1
var prediction = position
var HitCounter = 0

var Damaged = false
var DamagedTimer = 0
func _process(delta):
	
	#Colour change for taking damage
	if Damaged:
		DamagedTimer += delta
		if DamagedTimer > 0.25:
			Damaged = false
			body_animation.modulate = Color(1, 1, 1)
			DamagedTimer = 0
	
	pointToPlayer = player.global_position - eye.global_position
	eye.global_position = global_position + (pointToPlayer.normalized() * distance)
	
	if(HitCounter != 0):
		setHP(HP - (HitCounter * game_manager.get_player_damage()))
		HitCounter = 0
	


func attack():
	attack_sound.play()
	var attack = attackPath.instantiate()
	attack.name = "FlyingEnemyAttack"
	add_child(attack)
	attack.global_position.x = global_position.x
	attack.global_position.y = global_position.y +5

	
	#predict where player is going
	prediction = player.global_position - attack.global_position
	
	#attack.velocity = prediction  - attack.global_position
	attack.velocity = prediction 

func setHP(value):
	HP = value
	health_bar.setHP(HP)
	
	#Death
	if(HP <= 0):
		#Reward player
		game_manager.add_point()
		
		#Generate on-death effect
		var deathParticles = ENEMY_DEATH_PARTICLES.instantiate()
		deathParticles.global_position = global_position
		get_parent().add_child(deathParticles)
		#Delete Boss
		queue_free()





const SPEED = 80
var nextPosition = global_position

func _physics_process(delta):
	
	if (cooldownTimer >= cooldown):
		attack()
		directionLogic()
		cooldownTimer = 0
	elif cooldownTimer < cooldown:
		cooldownTimer += delta
	
	#Move towards next position until within +- 5 pixels, then find new target position
	if ((global_position.x >= nextPosition.x + 5) or (global_position.x <= nextPosition.x - 5)) and((global_position.y >= nextPosition.y + 5) or (global_position.y <= nextPosition.y - 5)):
		velocity = (nextPosition-global_position).normalized() *SPEED
	else:
		velocity = Vector2(0,0)
	move_and_slide()
	
func directionLogic():
	#control horizontal movement
	if(global_position.x >= player.global_position.x):
		nextPosition.x = player.global_position.x - 10
	else:
		nextPosition.x = player.global_position.x + 10
	
	nextPosition.y = player.global_position.y - 50

func checkDeath():
	if(HP <= 0):
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		#Reward the player
		game_manager.add_point()
		#Delete enemy
		queue_free()


func _on_enemy_hit_box_lmb_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot1_damage()
	health_bar.loseHP(game_manager.get_slot1_damage())
	checkDeath()
	applyDamaged()


func _on_enemy_hit_box_lmb_persistent_body_entered(body):
	HP -= game_manager.get_slot2_damage()
	health_bar.loseHP(game_manager.get_slot2_damage())
	checkDeath()
	applyDamaged()

func _on_enemy_hit_box_rmb_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot1_damage()
	health_bar.loseHP(game_manager.get_slot1_damage())
	checkDeath()
	applyDamaged()

func _on_enemy_hit_box_rmb_persistent_body_entered(body):
	HP -= game_manager.get_slot2_damage()
	health_bar.loseHP(game_manager.get_slot2_damage())
	checkDeath()
	applyDamaged()

func applyDamaged():
	damaged_sound.playing = true
	body_animation.modulate = Color(255,0,0)
	Damaged = true
	DamagedTimer = 0
