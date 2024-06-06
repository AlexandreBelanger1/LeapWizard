extends Node2D
@onready var enter_portal_label = $EnterPortalLabel
@onready var game_manager = $"../.."
var playerFlag = false
@onready var enter_portal_button = $EnterPortalButton

func _on_area_2d_body_entered(_body):
	playerFlag = true
	enter_portal_button.visible = true
	enter_portal_label.visible = true


func _on_area_2d_body_exited(_body):
	playerFlag = false
	enter_portal_button.visible = false
	enter_portal_label.visible = true

#func _input(event):
	#if event.is_action_pressed("Interact") and playerFlag:
		#playerFlag = false
		#print_debug("inPortal")
		#game_manager.NextWorld()
		#queue_free()


func _on_enter_portal_button_pressed():
	game_manager.NextWorld()
