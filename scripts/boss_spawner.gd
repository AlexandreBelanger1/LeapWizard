extends Node2D

@onready var tile_map = $"../TileMap"
@onready var game_manager = $".."
@onready var activate_boss = $ActivateBoss

const FIRST_BOSS_1 = preload("res://scenes/first_boss_1.tscn")
const COMPUTER_BOSS_FIGHT = preload("res://scenes/TileGeneration/computer_boss_fight.tscn")
var playerInSpawnerFlag = false


func _on_area_2d_body_entered(_body):
	playerInSpawnerFlag = true
	activate_boss.visible = true
func _on_area_2d_body_exited(_body):
	playerInSpawnerFlag = false
	activate_boss.visible = false
		
		
func _input(event):
	if event.is_action_pressed("Interact") and playerInSpawnerFlag:
		var boss = COMPUTER_BOSS_FIGHT.instantiate()
		get_parent().add_child(boss)
		boss.global_position.x = global_position.x
		boss.global_position.y = global_position.y
		game_manager.pauseMusic()
		queue_free()




