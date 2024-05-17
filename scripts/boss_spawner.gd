extends Node2D
const BOSSpath = preload("res://scenes/boss.tscn")
@onready var tile_map = $"../TileMap"
@onready var game_manager = $".."
const FIRST_BOSS = preload("res://scenes/FirstBoss.tscn")
var playerInSpawnerFlag = false
var bossEnabled = false
@onready var activate_boss = $ActivateBoss

func _on_area_2d_body_entered(body):
	if(body.name == "Player") and bossEnabled:
		playerInSpawnerFlag = true
		activate_boss.visible = true
func _on_area_2d_body_exited(body):
	if(body.name == "Player") and bossEnabled:
		playerInSpawnerFlag = false
		activate_boss.visible = false
		
		
func _input(event):
	if event.is_action_pressed("Interact") and playerInSpawnerFlag and bossEnabled:
		var boss = FIRST_BOSS.instantiate()
		boss.global_position.x = global_position.x
		boss.global_position.y = global_position.y-150
		boss.nextPosition = global_position
		boss.name = "Boss"
		get_parent().add_child(boss)
		tile_map.set_layer_enabled(4,true)
		queue_free()




