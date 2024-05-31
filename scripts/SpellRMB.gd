extends CharacterBody2D
const SPARKS = preload("res://scenes/sparks.tscn")
var speed = 270

func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_spell_map_hitbox_body_entered(_body):
	var sparks = SPARKS.instantiate()
	get_parent().add_child(sparks)
	sparks.global_position = global_position
	queue_free()

func _on_spell_enemy_hitbox_body_entered(body):
	body.takeRMBDamage()
	var sparks = SPARKS.instantiate()
	get_parent().add_child(sparks)
	sparks.global_position = global_position
	queue_free()

