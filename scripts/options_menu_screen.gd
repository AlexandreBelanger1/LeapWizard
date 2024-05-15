extends Control

@onready var menu_screen = $"../MenuScreen"


func _on_back_pressed():
	menu_screen.visible = true
	visible = false
