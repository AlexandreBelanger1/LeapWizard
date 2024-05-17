extends CharacterBody2D

@onready var game_manager = $".."
@onready var camera_2d = $"../Camera2D"
@onready var tile_map = $"../TileMap"
@onready var player = $"../Player"
@onready var attack_sound = $AttackSound
@onready var eye = $EyeShoot/Eye
@onready var health_bar = $HealthBar
const BOSS_DEATH_PARTICLES = preload("res://scenes/boss_death_particles.tscn")
@onready var continuous_music = $ContinuousMusic
const NEXT_WORLD_PORTAL = preload("res://scenes/next_world_portal.tscn")

func _ready():
	game_manager.pauseMusic()
	#camera_2d.add_child(health_bar)


var BossHP = 250
const distance = 5
var a = position
const attackPath = preload('res://scenes/boss_attack.tscn')
var cooldownTimer: float
var cooldown = 0.5
var prediction = position
var HitCounter = 0

func _process(delta):
	
	a = player.global_position - eye.global_position
	eye.global_position = global_position + (a.normalized() * distance)
	
	if(HitCounter != 0):
		setHP(BossHP - (HitCounter * game_manager.get_player_damage()))
		HitCounter = 0
	
	if (cooldownTimer > cooldown):
		attack()
		cooldownTimer = 0
	elif cooldownTimer < cooldown:
		cooldownTimer += delta

func attack():
	attack_sound.play()
	var attack = attackPath.instantiate()
	attack.name = "BossAttack"
	add_child(attack)
	attack.global_position = global_position
	
	#predict where player is going
	prediction = + player.global_position + (player.velocity.normalized() * 40)  
	
	attack.velocity = prediction  - attack.global_position

func setHP(value):
	BossHP = value
	health_bar.value = BossHP
	
	#BossDeath
	if(BossHP <= 0):
		tile_map.set_layer_enabled(4,false)
		#Generate on-death effect
		var deathParticles = BOSS_DEATH_PARTICLES.instantiate()
		deathParticles.global_position = global_position
		get_parent().add_child(deathParticles)
		#Unpause music
		game_manager.unpauseMusic()
		#Create Portal to next world
		var Portal = NEXT_WORLD_PORTAL.instantiate()
		get_parent().add_child(Portal)
		Portal.global_transform.y = 0
		Portal.global_transform.x = player.global_transform.x - 100
		print_debug(Portal.global_position)
		#Delete Boss
		queue_free()


const SPEED = 120
var nextPosition = global_position

func _physics_process(delta):
	
	
	
	if (global_position.x >= nextPosition.x + 5) or (global_position.x <= nextPosition.x - 5):
		if (global_position.y >= nextPosition.y + 5) or (global_position.y <= nextPosition.y - 5):
			velocity = (nextPosition-global_position).normalized() *SPEED
			#velocity.x = ((nextPosition.x-global_position.x))
			#velocity.y = ((nextPosition.y-global_position.y))
		else:
			directionLogic()
	else:
		directionLogic()
	move_and_slide()
	
func directionLogic():
	nextPosition = player.global_position



func _on_intro_music_finished():
	continuous_music.playing = true


func _on_continuous_music_finished():
	continuous_music.playing = true

func _on_enemy_hit_box_lmb_body_entered(body):
	body.queue_free()
	BossHP -= game_manager.get_slot1_damage()
	health_bar.value = BossHP
	checkDeath()


func _on_enemy_hit_box_lmb_persistent_body_entered(body):
	BossHP -= game_manager.get_slot2_damage()
	health_bar.value = BossHP
	checkDeath()

func _on_enemy_hit_box_rmb_body_entered(body):
	body.queue_free()
	BossHP -= game_manager.get_slot1_damage()
	health_bar.value = BossHP
	checkDeath()

func _on_enemy_hit_box_rmb_persistent_body_entered(body):
	BossHP -= game_manager.get_slot2_damage()
	health_bar.value = BossHP
	checkDeath()

func checkDeath():
	if(BossHP <= 0):
		tile_map.set_layer_enabled(4,false)
		#Generate on-death effect
		var deathParticles = BOSS_DEATH_PARTICLES.instantiate()
		deathParticles.global_position = global_position
		get_parent().add_child(deathParticles)
		#Unpause music
		game_manager.unpauseMusic()
		
		var Portal = NEXT_WORLD_PORTAL.instantiate()
		get_parent().add_child(Portal)
		Portal.global_position.y = 0
		Portal.global_position.x = player.global_position.x - 100
		print_debug(Portal.global_position)
		#Delete Boss
		queue_free()

