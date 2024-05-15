extends Node2D
@onready var game_manager = $"../.."
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
var HP = 25

func flipSlime(value):
	animated_sprite_2d.flip_h = value

func _on_enemy_hit_box_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot1_damage()
	health_bar.loseHP(game_manager.get_slot1_damage())
	if(HP <= 0):
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		print_debug(global_position)
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		print_debug(deathSmoke.global_position)
		#Reward the player
		game_manager.add_point()
		#Delete enemy
		queue_free()


func _on_enemy_hitbox_rmb_body_entered(body):
	body.queue_free()
	HP -= game_manager.get_slot2_damage()
	health_bar.loseHP(game_manager.get_slot2_damage())
	if(HP <= 0):
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		print_debug(global_position)
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		print_debug(deathSmoke.global_position)
		#Reward the player
		game_manager.add_point()
		#Delete enemy
		queue_free()
