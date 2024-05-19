extends Control

@onready var game_manager = $".."
const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
@onready var player_loadout_panel = $PlayerLoadoutPanel
@onready var companion_loadout_panel = $CompanionLoadoutPanel
@onready var player_upgrade_currency_count = $"player upgrade currency count"

var player_currency
var companion_currency
func _ready():
	player_currency = game_manager.get_player_upgrade_currency()
	companion_currency = game_manager.get_companion_upgrade_currency()
	player_upgrade_currency_count.text = "player upgrade currency: " + str(player_currency)

func _on_begin_run_pressed():
	
	var GameScene = GAME_SCENE_2.instantiate()
	get_parent().add_child(GameScene)
	queue_free()


func _on_player_loadout_pressed():
	player_loadout_panel.visible = true
	player_currency += 1
	game_manager.set_player_upgrade_currency(player_currency)
	player_upgrade_currency_count.text = "player upgrade currency: " + str(player_currency)


func _on_player_loadout_done_button_pressed():
	player_loadout_panel.visible = false


func _on_companion_loadout_pressed():
	companion_loadout_panel.visible = true
	game_manager.save_game()
	print_debug(game_manager.get_player_upgrade_currency())


func _on_companion_loadout_done_button_pressed():
	companion_loadout_panel.visible = false



func _on_load_pressed():
	game_manager.load_game()
	player_currency = game_manager.get_player_upgrade_currency()
	companion_currency = game_manager.get_companion_upgrade_currency()
	player_upgrade_currency_count.text = "player upgrade currency: " + str(player_currency)


func _on_save_pressed():
	game_manager.save_game()
