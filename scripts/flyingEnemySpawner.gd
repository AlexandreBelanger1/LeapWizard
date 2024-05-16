extends Node2D

const FLYING_ENEMY = preload("res://scenes/FlyingEnemy.tscn")

func _on_area_2d_body_entered(body):
	var flyingEnemy = FLYING_ENEMY.instantiate()
	get_parent().add_child(flyingEnemy)
	flyingEnemy.global_position.x = global_position.x
	flyingEnemy.global_position.y = global_position.y - 32
	flyingEnemy.nextPosition = body.position
	flyingEnemy.name = "FlyingEnemy"
	queue_free()
