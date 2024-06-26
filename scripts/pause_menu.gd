extends Control

var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause_game"):
		if(_is_paused):
			_is_paused = false
		else:
			_is_paused = true

func _on_resume_pressed():
	_is_paused = false

func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	_is_paused = false
	get_tree().reload_current_scene()
	
	#get_tree().change_scene_to_file('res://scenes/menu_screen.tscn')


func _on_sfx_volume_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_music_volume_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))
