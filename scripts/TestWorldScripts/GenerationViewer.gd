extends Node2D
@onready var game_manager = $".." 
@onready var activate_boss = $ActivateBoss

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
		game_manager.viewWorldGen()
		queue_free()
