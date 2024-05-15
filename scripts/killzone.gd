extends Area2D
@onready var timer = $Timer



func _on_body_entered(body):
	if(body.name == "Player"):
		print("You Died")
		timer.start()
		


func _on_timer_timeout():
	get_tree().reload_current_scene()


func _on_hit_box_body_entered(body):
	pass # Replace with function body.
