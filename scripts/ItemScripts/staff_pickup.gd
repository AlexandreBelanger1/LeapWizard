extends Node2D
@onready var game_manager = $".."
@onready var label = $Label


var playerInArea = false
func _on_area_2d_body_entered(_body):
	playerInArea = true
	label.visible = true


func _on_area_2d_body_exited(_body):
	playerInArea = false
	label.visible = false

func _input(event):
	if event.is_action_pressed("Cast1") and playerInArea:
		game_manager.set_slot1_name("staff")
		queue_free()
	elif event.is_action_pressed("Cast2") and playerInArea:
		game_manager.set_slot2_name("staff")
		queue_free()
