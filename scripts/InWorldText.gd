extends Control



func _on_player_detector_body_entered(body):
	if(body.name == "Player"):
		visible = true
		


func _on_player_detector_body_exited(body):
	if(body.name == "Player"):
		visible = false


func _on_close_button_pressed():
	queue_free()
