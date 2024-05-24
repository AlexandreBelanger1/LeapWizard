extends CharacterBody2D
@onready var game_manager = $".."
@onready var eye = $BodyAnimation/Eye
@onready var boss_continuous_music = $BossContinuousMusic
@onready var player = $"../Player"
@onready var tile_map = $"../TileMap"
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_down = $RayCastDown
@onready var body_animation = $BodyAnimation
@onready var damaged_sound = $DamagedSound

@onready var BOSS_HP_BAR = preload("res://scenes/boss_hp_bar.tscn")

const FLYING_ENEMY = preload("res://scenes/FlyingEnemy.tscn")
const FIRST_BOSS_1_TILEMAP = preload("res://scenes/First_boss_1_tilemap.tscn")
const BOSS_DEATH_PARTICLES = preload("res://scenes/boss_death_particles.tscn")
const attackPath = preload('res://scenes/boss_attack.tscn')
const eyeDistance = 5
const SPEED = 150
var nextPosition = position
var BossTiles

var Damaged = false
var DamagedTimer = 0

var HP = 2500
var pointToPlayer = position
var health_bar
func _ready():
	addHPBarAndTilemap()
	setInitialVelocity()


func _physics_process(_delta):
	if ray_cast_down.is_colliding():
		velocity.y = -velocity.y
	if ray_cast_up.is_colliding():
		velocity.y = -velocity.y
	if ray_cast_right.is_colliding():
		velocity.x = -velocity.x
	if ray_cast_left.is_colliding():
		velocity.x = -velocity.x
	move_and_slide()

var cooldown = 3
var cooldownTimer = 0
func _process(delta):
	
	if Damaged:
		DamagedTimer += delta
		if DamagedTimer > 0.25:
			Damaged = false
			body_animation.modulate = Color(1, 1, 1)
			DamagedTimer = 0
	
	health_bar.setName("Noodlesworth")
	pointToPlayer = player.global_position - eye.global_position
	eye.global_position = global_position + (pointToPlayer.normalized() * eyeDistance)
	health_bar.global_position.x = player.global_position.x - 100
	health_bar.global_position.y = player.global_position.y - 110
	
	#spawn enemies
	if (cooldownTimer >= cooldown):
		attack()
		cooldownTimer = 0
	elif cooldownTimer < cooldown:
		cooldownTimer += delta

func attack():
	var enemy = FLYING_ENEMY.instantiate()
	BossTiles.add_child(enemy)
	enemy.global_position.x = global_position.x
	enemy.global_position.y = global_position.y


#Take damage & check death

func _on_enemy_hit_box_lmb_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot1_damage()
	health_bar.setHP(HP)
	checkDeath()
	applyDamaged()


func _on_enemy_hit_box_lmb_persistent_body_entered(_body):
	HP -= game_manager.get_slot2_damage()
	health_bar.setHP(HP)
	checkDeath()
	applyDamaged()


func _on_enemy_hit_box_rmb_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot1_damage()
	health_bar.setHP(HP)
	checkDeath()
	applyDamaged()


func _on_enemy_hit_box_rmb_persistent_body_entered(_body):
	HP -= game_manager.get_slot2_damage()
	health_bar.setHP(HP)
	checkDeath()
	applyDamaged()

func applyDamaged():
	damaged_sound.playing = true
	body_animation.modulate = Color(255,0,0)
	Damaged = true
	DamagedTimer = 0

func _on_boss_intro_music_finished():
	boss_continuous_music.playing = true


func _on_boss_continuous_music_finished():
	boss_continuous_music.playing = true

func checkDeath():
	if(HP <= 0):
		#Restore Map
		tile_map.set_layer_enabled(4,false)
		BossTiles.queue_free()
		#Spawn Death Animation
		var deathSmoke = BOSS_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		#Reward the player
		
		#Delete enemy
		queue_free()

func setInitialVelocity():
	var rng = RandomNumberGenerator.new()
	var randx = (rng.randf_range(global_position.x-5,global_position.x+5 ))
	var randy = (rng.randf_range(global_position.y-5,global_position.y+5 ))
	nextPosition.x = randx
	nextPosition.y = randy
	velocity = (nextPosition - global_position).normalized() * SPEED

func addHPBarAndTilemap():
	BossTiles = FIRST_BOSS_1_TILEMAP.instantiate()
	get_parent().add_child(BossTiles)
	BossTiles.global_position.x = 4600
	BossTiles.global_position.y = 0
	health_bar = BOSS_HP_BAR.instantiate()
	get_parent().add_child(health_bar)
