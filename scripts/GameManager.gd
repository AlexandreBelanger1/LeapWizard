extends Node
@onready var game_manager = %GameManager
@onready var player_ui = $"../Camera2D/PlayerUI"
@onready var pause_menu = $"../Camera2D/PauseMenu"
@onready var music = $"../Audio/Music"


var player_jump_count = 2
var player_speed
var player_jump 
var player_damage = 5
var score = 0
var HP = 4



func add_player_damage(value):
	player_damage += value
	player_ui.setDamage(player_damage)

func remove_points(value):
	score -= value
	player_ui.setEggs(score)

func add_point():
	score += 1
	player_ui.setEggs(score)
	
func _process(_delta):
	if Input.is_action_just_pressed("Pause_game"):
		pauseMenu()

func pauseMenu():
		pause_menu.show()
		get_tree().paused = true
		
func changeHealth(Value):
	HP += Value
	player_ui.setHealth(HP)
	if(HP < 1):
		#Animate Death
		#wait a bit
		get_tree().reload_current_scene()

func addJumps(Value):
	player_jump_count += Value
	player_ui.setJumps(player_jump_count)



