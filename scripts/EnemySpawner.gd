extends Node2D
@onready var game_manager = $"../.."
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
const HERMIT_CRAB = preload("res://scenes/hermit_crab.tscn")
const ARENA_RED_SLIME = preload("res://scenes/arena_red_slime.tscn")
@onready var animation_player = $AnimationPlayer

func spawn(enemyName: String):
	var spawnParticles = ENEMY_DEATH_PARTICLES.instantiate()
	print_debug(get_parent())
	get_parent().add_child(spawnParticles)
	spawnParticles.global_position = global_position
	if enemyName ==  "HERMIT_CRAB_LEFT":
		var enemy = HERMIT_CRAB.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.rotation = PI/2
		enemy.setMaxHP(300 + 50*game_manager.get_world_number())
	elif enemyName ==  "HERMIT_CRAB_RIGHT":
		var enemy = HERMIT_CRAB.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.rotation = -PI/2
		enemy.setMaxHP(300 + 50*game_manager.get_world_number())
	elif enemyName ==  "HERMIT_CRAB_UP":
		var enemy = HERMIT_CRAB.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.rotation = -PI
		enemy.setMaxHP(300 + 50*game_manager.get_world_number())
	elif enemyName == "RED_SLIME":
		var enemy = ARENA_RED_SLIME.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.setMaxHP(350 + 50*game_manager.get_world_number())
	queue_free()

func startSpawner(enemy: String):
	animation_player.play(enemy)
