extends CharacterBody2D

var speed = 270

func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()
	
func _on_body_entered(body):
	queue_free()


func _on_area_2d_area_entered(area):
	#queue_free()
	pass
	
