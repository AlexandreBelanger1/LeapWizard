extends CharacterBody2D

var speed = 150
var lifetime = 2
var timer = 0
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	timer+=delta
	if timer >= lifetime:
		queue_free()
	
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(_body):
	queue_free()
	
func _on_body_entered(_body):
	queue_free()
