extends Node2D

const ENEMY_SPAWNER = preload("res://scenes/enemy_spawner.tscn")
const CHEST = preload("res://scenes/chest.tscn")

@onready var tile_map = $TileMap
@onready var wave_timer = $WaveTimer
@onready var survive_label = $SurviveLabel
@onready var survive_timer = $SurviveTimer
@onready var reward_timer = $RewardTimer


var enemyCount = 0
var waveCount = 0
func startArena():
	print_debug("Starting Arena")
	tile_map.set_layer_enabled(3,true)
	wave_timer.start()
	survive_label.visible = true
	survive_timer.start()

func _on_wave_timer_timeout():
	if waveCount != 5:
		wave_timer.start()
		waveCount += 1
		spawnWave()


func spawnWave():
	var RNG = RandomNumberGenerator.new()
	for i in 3:
		var randomEnemy = RNG.randf_range(0,4)
		if randomEnemy <= 1:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabLeft")
			var rand = RNG.randf_range(16,176)
			enemy.global_position.x = global_position.x-112
			enemy.global_position.y = global_position.y-rand
		elif randomEnemy > 1 and randomEnemy <= 2:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabRight")
			var rand = RNG.randf_range(16,176)
			enemy.global_position.x = global_position.x+112
			enemy.global_position.y = global_position.y-rand
		elif  randomEnemy > 2 and randomEnemy <= 3:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabUp")
			var rand = RNG.randf_range(-112,112)
			enemy.global_position.x = global_position.x+ rand
			enemy.global_position.y = global_position.y-175
		elif  randomEnemy > 3:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("RedSlime")
			var rand = RNG.randf_range(-112,112)
			enemy.global_position.x = global_position.x+ rand
			enemy.global_position.y = global_position.y - 24



func _on_enemy_counter_body_entered(_body):
	enemyCount += 1

var rewardGenerated = false
func _on_enemy_counter_body_exited(_body):
	enemyCount -= 1
	print_debug(enemyCount)
	print_debug(waveCount)
	if enemyCount == 0 and waveCount == 5:
		reward_timer.start()



func _on_survive_timer_timeout():
	survive_label.visible = false


func _on_reward_timer_timeout():
	tile_map.set_layer_enabled(3,false)
	if !rewardGenerated:
		var reward = CHEST.instantiate()
		add_child(reward)
		reward.global_position.x = global_position.x
		reward.global_position.y = global_position.y-16
		print_debug(reward.global_position)
		rewardGenerated = true
