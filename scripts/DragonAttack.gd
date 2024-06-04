extends CharacterBody2D
@onready var sprite_2d = $Sprite2D
const SPARKS = preload("res://scenes/sparks.tscn")

var speed = 150
var lifetime = 2
var timer = 0
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	timer+=delta
	if timer >= lifetime:
		queue_free()

func flipSprite():
	sprite_2d.flip_h = true



func _on_player_hitbox_body_entered(body):
	body.takeDamage()
	var sparks = SPARKS.instantiate()
	get_parent().add_child(sparks)
	sparks.global_position = global_position
	queue_free()
