extends Node2D
@onready var enter_portal_label = $EnterPortalLabel
@onready var game_manager = $"../.."
var playerFlag = false

func _on_area_2d_body_entered(_body):
	playerFlag = true
	enter_portal_label.visible = true


func _on_area_2d_body_exited(_body):
	playerFlag = false
	enter_portal_label.visible = false

func _input(event):
	if event.is_action_pressed("Interact") and playerFlag:
		game_manager.NextWorld()
