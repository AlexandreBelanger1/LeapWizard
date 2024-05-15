extends Node2D
var insideRange = false
@onready var game_manager = $"../.."
@onready var interact_label = $InteractLabel


func _input(event):
	if event.is_action_pressed("Interact") and insideRange:
		game_manager.add_rune(1)
		queue_free()

func _on_range_body_entered(body):
	if(body.name=="Player"):
		interact_label.visible= true
		insideRange = true
		


func _on_range_body_exited(body):
	if(body.name=="Player"):
		insideRange = false
		interact_label.visible = false

