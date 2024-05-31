extends Control

@onready var game_manager = $".."
const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
@onready var player_loadout_panel = $PlayerLoadoutPanel
@onready var companion_loadout_panel = $CompanionLoadoutPanel
@onready var player_upgrade_currency_count = $"player upgrade currency count"
@onready var companion_upgrade_currency_count = $"companion upgrade currency count"
@onready var unlock_slimey_heart = $PlayerLoadoutPanel/UnlockSlimeyHeart
@onready var unlock_soul_mana = $PlayerLoadoutPanel/UnlockSoulMana
@onready var unlock_cat_scratch = $CompanionLoadoutPanel/UnlockCatScratch
@onready var unlock_egg_cat = $CompanionLoadoutPanel/UnlockEggCat


var player_currency
var companion_currency
func _ready():
	refreshCurrencyDisplay()
	unlock_slimey_heart.visible = !game_manager.get_player_loadout_array(1)
	unlock_soul_mana.visible = !game_manager.get_player_loadout_array(2)
	unlock_cat_scratch.visible = !game_manager.get_companion_loadout_array(1)
	unlock_egg_cat.visible = !game_manager.get_companion_loadout_array(2)

func _on_begin_run_pressed():
	
	var GameScene = GAME_SCENE_2.instantiate()
	get_parent().add_child(GameScene)
	queue_free()


func _on_player_loadout_pressed():
	player_loadout_panel.visible = true


func _on_player_loadout_done_button_pressed():
	player_loadout_panel.visible = false


func _on_companion_loadout_pressed():
	companion_loadout_panel.visible = true


func _on_companion_loadout_done_button_pressed():
	companion_loadout_panel.visible = false



func _on_load_pressed():
	game_manager.load_game()
	refreshCurrencyDisplay()


func _on_save_pressed():
	game_manager.save_game()


func _on_new_save_pressed():
	game_manager.new_save()
	

func _input(event):
	if event.is_action_pressed("DeveloperCheat"):
		game_manager.set_player_upgrade_currency(game_manager.get_player_upgrade_currency()+3)
		game_manager.set_companion_upgrade_currency(game_manager.get_companion_upgrade_currency()+3)
		refreshCurrencyDisplay()



#Player Loadout Unlocks

func _on_unlock_slimey_heart_pressed():
	if game_manager.get_player_upgrade_currency() >= 3:
		game_manager.set_player_upgrade_currency(game_manager.get_player_upgrade_currency()-3)
		refreshCurrencyDisplay()
		game_manager.set_player_loadout_array(1, true)
		unlock_slimey_heart.visible = false

func _on_unlock_soul_mana_pressed():
	if game_manager.get_player_upgrade_currency() >= 3:
		game_manager.set_player_upgrade_currency(game_manager.get_player_upgrade_currency()-3)
		refreshCurrencyDisplay()
		game_manager.set_player_loadout_array(2, true)
		unlock_soul_mana.visible = false

#Companion Loadout Unlocks
func _on_unlock_cat_scratch_pressed():
	if game_manager.get_companion_upgrade_currency() >= 3:
		game_manager.set_companion_upgrade_currency(game_manager.get_companion_upgrade_currency()-3)
		refreshCurrencyDisplay()
		game_manager.set_companion_loadout_array(2, true)
		unlock_cat_scratch.visible = false

func _on_unlock_egg_cat_pressed():
	if game_manager.get_companion_upgrade_currency() >= 3:
		game_manager.set_companion_upgrade_currency(game_manager.get_companion_upgrade_currency()-3)
		refreshCurrencyDisplay()
		game_manager.set_companion_loadout_array(1, true)
		unlock_egg_cat.visible = false

func refreshCurrencyDisplay():
	player_currency = game_manager.get_player_upgrade_currency()
	companion_currency = game_manager.get_companion_upgrade_currency()
	player_upgrade_currency_count.text = str(player_currency)
	companion_upgrade_currency_count.text = str(companion_currency)
