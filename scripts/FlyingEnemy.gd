extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var player = $"../../Player"
@onready var attack_sound = $AttackSound
@onready var eye = $EyeShoot/Eye
@onready var health_bar = $HealthBar
@onready var body_animation = $BodyAnimation
@onready var damaged_sound = $DamagedSound
const MANA_PICKUP = preload("res://scenes/items/mana_pickup.tscn")
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")

var HP = 250
const distance = 1
var pointToPlayer = position
const attackPath = preload('res://scenes/boss_attack.tscn')
var cooldownTimer: float
var cooldown = 1
var prediction = position


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
	


func attack():
	attack_sound.play()
	var attackprojectile = attackPath.instantiate()
	attackprojectile.name = "FlyingEnemyAttack"
	add_child(attackprojectile)
	attackprojectile.global_position.x = global_position.x
	attackprojectile.global_position.y = global_position.y +5

	
	#predict where player is going
	prediction = player.global_position - attackprojectile.global_position
	
	#attack.velocity = prediction  - attack.global_position
	attackprojectile.velocity = prediction 

func setHP(value):
	HP = value
	health_bar.setHP(HP)

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
		if game_manager.get_player_upgrade(1):
			var RNG = RandomNumberGenerator.new()
			var manaDropOdds = RNG.randf_range(0.0,10.0)
			if manaDropOdds > 8:
				var mana = MANA_PICKUP.instantiate()
				get_parent().get_parent().add_child(mana)
				mana.global_position = global_position
		game_manager.add_point()
		#Delete enemy
		call_deferred("free")
		#queue_free()

func applyDamaged():
	damaged_sound.playing = true
	body_animation.modulate = Color(255,0,0)
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
