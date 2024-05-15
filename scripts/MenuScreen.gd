extends Control
#const OPTIONS_MENU_SCREEN = preload("res://scenes/options_menu_screen.tscn")
const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
const GAME = preload("res://scenes/game.tscn")
@onready var game_manager = $".."

@onready var options_menu = $"../OptionsMenu"
@onready var audio_stream_player = $AudioStreamPlayer
func _on_play_pressed():
	var GameScene = GAME.instantiate()
	get_parent().add_child(GameScene)
	queue_free()

func _on_quit_pressed():
	get_tree().quit()

func _on_options_pressed():
	options_menu.visible = true
	visible = false
	


func _on_audio_stream_player_finished():
	audio_stream_player.playing = true



func _on_play_2_pressed():
	var GameScene = GAME_SCENE_2.instantiate()
	get_parent().add_child(GameScene)
	game_manager.score = 10
	queue_free()
