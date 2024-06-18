extends Node2D
const ENEMY_SPAWNER = preload("res://scenes/enemy_spawner.tscn")
@onready var tile_map = $TileMap
@onready var wave_timer = $WaveTimer
@onready var survive_label = $SurviveLabel
@onready var survive_timer = $SurviveTimer

var enemyCount = 0
var waveCount = 0
func startArena():
	print_debug("Starting Arena")
	tile_map.set_layer_enabled(3,true)
	wave_timer.start()
	survive_label.visible = true
	survive_timer.start()

func _on_wave_timer_timeout():
	if waveCount <4:
		wave_timer.start()
		waveCount += 1
		spawnWave()
	else:
		waveCount += 1


func spawnWave():
	var RNG = RandomNumberGenerator.new()
	for i in 3:
		if i == 0:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabLeft")
			var rand = RNG.randf_range(16,176)
			enemy.global_position.x = global_position.x-112
			enemy.global_position.y = global_position.y-rand
		elif i == 1:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabRight")
			var rand = RNG.randf_range(16,176)
			enemy.global_position.x = global_position.x+112
			enemy.global_position.y = global_position.y-rand
		elif i == 2:
			var enemy = ENEMY_SPAWNER.instantiate()
			add_child(enemy)
			enemy.startSpawner("HermitCrabUp")
			var rand = RNG.randf_range(-112,112)
			enemy.global_position.x = global_position.x+ rand
			enemy.global_position.y = global_position.y-175



func _on_enemy_counter_body_entered(_body):
	enemyCount += 1


func _on_enemy_counter_body_exited(_body):
	enemyCount -= 1
	if enemyCount == 0 and waveCount > 4:
		tile_map.set_layer_enabled(3,false)


func _on_survive_timer_timeout():
	survive_label.visible = false
