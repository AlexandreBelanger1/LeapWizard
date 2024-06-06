extends Node2D
@onready var game_manager = $"../.."
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var damaged_sound = $DamagedSound
const HALF_HEART_PICKUP = preload("res://scenes/items/half_heart_pickup.tscn")
const HEART_PICKUP = preload("res://scenes/items/heart_pickup.tscn")
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
var HP = 350

var Damaged = false
var DamagedTimer = 0
func _process(delta):
	if Damaged:
		DamagedTimer += delta
		if DamagedTimer > 0.25:
			Damaged = false
			animated_sprite_2d.modulate = Color(1, 1, 1)
			DamagedTimer = 0


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
		print_debug("slime dead")
		dead = true
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		#Reward the player
		if game_manager.get_player_upgrade(1):
			var RNG = RandomNumberGenerator.new()
			var heartDropOdds = RNG.randf_range(0.0,10.0)
			if heartDropOdds > 8 and heartDropOdds < 9.5:
				var heart = HALF_HEART_PICKUP.instantiate()
				get_parent().get_parent().add_child(heart)
				heart.global_position = global_position
			elif heartDropOdds > 9.5:
				var heart = HEART_PICKUP.instantiate()
				get_parent().get_parent().add_child(heart)
				heart.global_position = global_position
		game_manager.add_point()
		#Delete enemy
		call_deferred("free")
		#queue_free()

func applyDamaged():
	damaged_sound.playing = true
	animated_sprite_2d.modulate = Color(0,0,255)
	Damaged = true
	DamagedTimer = 0
