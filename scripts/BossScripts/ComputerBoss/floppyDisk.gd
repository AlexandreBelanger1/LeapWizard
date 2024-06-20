extends CharacterBody2D
@onready var disk = $Disk

var speed = 60
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)



func _on_player_hitbox_body_entered(body):
	body.takeDamage()
	queue_free()


func _on_lifetime_timeout():
	call_deferred("free")

func selectFrame(value: int):
	disk.frame = value
