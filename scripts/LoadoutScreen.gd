extends Control

@onready var game_manager = $".."
const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
@onready var player_loadout_panel = $PlayerLoadoutPanel
@onready var companion_loadout_panel = $CompanionLoadoutPanel
@onready var player_upgrade_currency_count = $"player upgrade currency count"


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

