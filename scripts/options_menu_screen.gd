extends Control

@onready var menu_screen = $"../MenuScreen"


func _on_back_pressed():
	menu_screen.visible = true
	visible = false


func _on_sfx_volume_value_changed(value):

	var sfx_index= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_music_volume_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))
