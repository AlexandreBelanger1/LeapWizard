extends CharacterBody2D

var speed = 150
var lifetime = 2
var timer = 0
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	timer+=delta
	if timer >= lifetime:
		queue_free()




func _on_map_hitbox_body_entered(_body):
	queue_free()


func _on_player_hitbox_body_entered(body):
	body.takeDamage()
	queue_free()

