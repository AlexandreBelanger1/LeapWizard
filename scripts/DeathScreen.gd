extends Control

@onready var game_manager = $"../.."
@onready var fade_timer = $FadeTimer


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_new_run_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func fadeIn():
	fade_timer.start()

func _on_fade_timer_timeout():
	modulate.a += 0.1
	if modulate.a >= 1:
		fade_timer.stop()
		get_tree().paused = true
