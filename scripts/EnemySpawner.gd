extends Node2D

const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
const HERMIT_CRAB = preload("res://scenes/hermit_crab.tscn")
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
		#enemy.setHPBarPosition()
	elif enemyName ==  "HERMIT_CRAB_RIGHT":
		var enemy = HERMIT_CRAB.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.rotation = -PI/2
		#enemy.setHPBarPosition()
	elif enemyName ==  "HERMIT_CRAB_UP":
		var enemy = HERMIT_CRAB.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
		enemy.rotation = PI
		#enemy.setHPBarPosition()
	queue_free()

func startSpawner(enemy: String):
	animation_player.play(enemy)
