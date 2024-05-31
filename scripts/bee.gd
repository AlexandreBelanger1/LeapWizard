extends CharacterBody2D
@onready var timer = $Timer
@onready var aggro_range = $AggroRange
@onready var damage_box = $DamageBox


const speed = 90
var currentTarget
var damageCooldown = 1
var damageTimer = 0
var firstVelocity
func _ready():
	timer.start()

func _on_area_2d_body_entered(body):
	if currentTarget == null:
		currentTarget = body
		if firstVelocity == null:
			firstVelocity = velocity
	

func _physics_process(delta):
	if currentTarget != null:
		aggro_range.set_collision_mask_value(3,false)
		velocity = currentTarget.global_position - global_position
	elif firstVelocity != null:
		aggro_range.set_collision_mask_value(3,true)
		velocity = firstVelocity
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if damageTimer < damageCooldown :
		damage_box.set_collision_mask_value(3,true)
	elif damageTimer  >= damageCooldown:
		damage_box.set_collision_mask_value(3,false)
	if damageTimer > 2*damageCooldown:
		damageTimer  = 0
	damageTimer += delta
	


func _on_timer_timeout():
	queue_free()


func _on_damage_box_body_entered(body):
	body.takeLMBDamage()
