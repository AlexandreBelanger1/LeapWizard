extends CharacterBody2D
@onready var sprite = $Sprite
const SHIELD_BULLET = preload("res://scenes/shield_bullet.tscn")
var HP = 1
var distance = 32
var pointToMouse = position
func _physics_process(_delta):
	if Input.is_action_just_released("Cast1"):
		shoot()
		call_deferred("free")
	pointToMouse = get_global_mouse_position() - global_position
	#global_position = get_parent().global_position + (pointToMouse.normalized() * distance)
	
	if(pointToMouse.x >0):
		rotation = (atan( pointToMouse.y/pointToMouse.x)) 
	else:
		rotation =(PI+ atan( pointToMouse.y/pointToMouse.x)) 
		
	if HP > 0:
		sprite.frame = HP

func addValue():
		if HP < 4:
			HP +=1


func shoot():
	var bullet = SHIELD_BULLET.instantiate()
	bullet.setPower(HP)
	bullet.setMouseButton(1)
	get_parent().get_parent().add_child(bullet)
	bullet.global_position = sprite.global_position
	bullet.velocity = pointToMouse
	bullet.rotation =  rotation

func takeDamage():
	HP -= 1
	checkDeath()

func checkDeath():
	if HP < 1:
		call_deferred("free")
