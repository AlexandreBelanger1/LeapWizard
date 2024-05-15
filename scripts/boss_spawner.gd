extends Node2D
const BOSSpath = preload("res://scenes/boss.tscn")
@onready var tile_map = $"../TileMap"
@onready var game_manager = $".."

var playerInSpawnerFlag = false
var bossEnabled = false

func _on_area_2d_body_entered(body):
	if(body.name == "Player") and bossEnabled:
		playerInSpawnerFlag = true

func _on_area_2d_body_exited(body):
	if(body.name == "Player") and bossEnabled:
		playerInSpawnerFlag = false
		
		
func _input(event):
	if event.is_action_pressed("Interact") and playerInSpawnerFlag and bossEnabled:
		var boss = BOSSpath.instantiate()
		boss.global_position = global_position
		boss.nextPosition = global_position
		boss.name = "Boss"
		get_parent().add_child(boss)
		tile_map.set_layer_enabled(4,true)
		queue_free()




