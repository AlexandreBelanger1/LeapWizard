extends Node
#@onready var game_manager = %GameManager
@onready var player_ui = $Camera2D/PlayerUI
@onready var pause_menu = $Camera2D/PauseMenu
@onready var game_manager = $".."
const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
@onready var music = $Audio/Music

func pauseMusic():
	music.stream_paused = true

func unpauseMusic():
	music.stream_paused = false

func add_player_damage(value):
	game_manager.add_player_damage(value)
	player_ui.setDamage(game_manager.get_player_damage())

func remove_points(value):
	game_manager.remove_points(value)
	player_ui.setEggs(game_manager.get_player_score())

func add_point():
	game_manager.add_point()
	player_ui.setEggs(game_manager.get_player_score())
	
func _process(_delta):
	if Input.is_action_just_pressed("Pause_game"):
		pauseMenu()

func pauseMenu():
		pause_menu.show()
		get_tree().paused = true
		
func changeHealth(Value):
	game_manager.changeHealth(Value)
	player_ui.setHealth(game_manager.get_player_HP())
	if(game_manager.get_player_HP() < 1):
		#Animate Death
		#wait a bit
		get_tree().reload_current_scene()

func addJumps(Value):
	game_manager.addJumps(Value)
	player_ui.setJumps(get_player_jumps())
	
func get_player_damage():
	return game_manager.get_player_damage()

func get_player_jumps():
	return game_manager.get_player_jumps()

func get_player_speed():
	return game_manager.get_player_speed()

func get_player_score():
	return game_manager.get_player_score()

func get_player_HP():
	return game_manager.get_player_HP()


func _on_teleporter_body_entered(body):
	var GameScene2 = GAME_SCENE_2.instantiate()
	get_parent().add_child(GameScene2)
	queue_free()
