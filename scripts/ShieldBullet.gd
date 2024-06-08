extends CharacterBody2D
@onready var sprite = $Sprite

var speed = 220
var power = 1
var MB  = 0
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	sprite.frame = power

func _on_enemy_hitbox_body_entered(body):
	for i in power:
		if MB == 0:
			body.takeLMBDamage()
		else:
			body.takeRMBDamage()



func _on_timer_timeout():
	queue_free()

func setPower(value: int):
	power = value

func setMouseButton(value: int):
	MB = value
