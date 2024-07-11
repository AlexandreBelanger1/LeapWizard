extends Node2D
@onready var game_manager = $"../.."
const FLY_ENEMY = preload("res://scenes/FlyEnemy.tscn")
const FLYING_ENEMY = preload("res://scenes/FlyingEnemy.tscn")
const DRAGON = preload("res://scenes/dragon.tscn")
var ENEMY_PATH = FLY_ENEMY
var difficulty = 0
var RNG = RandomNumberGenerator.new()

func _on_visible_on_screen_notifier_2d_screen_entered():
	generateEnemy()


func generateEnemy():
	var flyingEnemy = ENEMY_PATH.instantiate()
	get_parent().add_child(flyingEnemy)
	flyingEnemy.global_position.x = global_position.x
	flyingEnemy.global_position.y = global_position.y
	if ENEMY_PATH == FLY_ENEMY:
		flyingEnemy.setMaxHP(250 + 40*game_manager.get_world_number())
	if ENEMY_PATH == DRAGON:
		flyingEnemy.setMaxHP(350 + 50*game_manager.get_world_number())
	if ENEMY_PATH == FLYING_ENEMY:
		flyingEnemy.setMaxHP(250 + 50*game_manager.get_world_number())
	queue_free()

func _on_setup_timer_timeout():
	var rand = RNG.randf_range(0,10)
	if rand > 0.5:
		call_deferred("free")
	else:
		difficulty = game_manager.get_world_number()
		if difficulty == 0:
			ENEMY_PATH = FLY_ENEMY
		elif difficulty == 1:
			var randEnemy = RNG.randf_range(0,2)
			if randEnemy < 1:
				ENEMY_PATH = FLY_ENEMY
			else:
				ENEMY_PATH = DRAGON
		elif difficulty >= 2:
			var randEnemy = RNG.randf_range(0,6+difficulty)
			if randEnemy < 2:
				ENEMY_PATH = FLY_ENEMY
			elif randEnemy < 4:
				ENEMY_PATH = DRAGON
			elif randEnemy >= 4:
				ENEMY_PATH = FLYING_ENEMY
