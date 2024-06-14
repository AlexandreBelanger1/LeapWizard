extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var damaged_sound = $DamagedSound
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight


const HALF_HEART_PICKUP = preload("res://scenes/items/half_heart_pickup.tscn")
const HEART_PICKUP = preload("res://scenes/items/heart_pickup.tscn")
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
var HP = 350
var speed = 40
var Damaged = false
var DamagedTimer = 0
var RNG = RandomNumberGenerator.new()
var randomDirection = 0
var dir = Vector2(0,0)

func _process(delta):
	if Damaged:
		DamagedTimer += delta
		if DamagedTimer > 0.25:
			Damaged = false
			animated_sprite_2d.modulate = Color(1, 1, 1)
			DamagedTimer = 0

func _ready():
	randomDirection = RNG.randf_range(0,2)

func _physics_process(delta):
	if randomDirection > 1 :
		flipSlime(true)
		#If no collision left, move left
		if !ray_cast_left.is_colliding():
			
			dir = Vector2(-1,0)
		#Otherwise, move right
		else:
			randomDirection  = 0
			dir = Vector2(1,0)
	elif randomDirection <= 1 :
		flipSlime(false)
		#If no collision right, move right
		if !ray_cast_right.is_colliding():
			dir = Vector2(1,0)
		#Otherwise, move left
		else:
			randomDirection  = 2
			dir = Vector2(-1,0)
	if ray_cast_left.is_colliding()  and ray_cast_right.is_colliding():
		dir = Vector2(0,0)
	velocity = dir * speed
	move_and_slide()

func flipSlime(value):
	animated_sprite_2d.flip_h = value


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
		if game_manager.get_player_upgrade(1):
			#var RNG = RandomNumberGenerator.new()
			var heartDropOdds = RNG.randf_range(0.0,10.0)
			if heartDropOdds > 8 and heartDropOdds < 9.5:
				var createItem := func():
					var heart = HALF_HEART_PICKUP.instantiate()
					get_parent().get_parent().add_child(heart)
					heart.global_position = global_position
				createItem.call_deferred()
			elif heartDropOdds > 9.5:
				var createItem2 := func():
					var heart = HEART_PICKUP.instantiate()
					get_parent().get_parent().add_child(heart)
					heart.global_position = global_position
				createItem2.call_deferred()
		game_manager.add_point()
		#Delete enemy
		call_deferred("free")
		#queue_free()

func applyDamaged():
	damaged_sound.playing = true
	animated_sprite_2d.modulate = Color(0,0,255)
	Damaged = true
	DamagedTimer = 0
