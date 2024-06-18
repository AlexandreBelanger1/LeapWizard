extends CharacterBody2D
@onready var sprite = $Sprite

var speed = 180
var power = 1
var MB  = 0
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)

func _on_enemy_hitbox_body_entered(body):
	if MB == 0:
		body.takeLMBDamage()
	else:
		body.takeRMBDamage()



func _on_timer_timeout():
	queue_free()


func setMouseButton(value: int):
	MB = value
