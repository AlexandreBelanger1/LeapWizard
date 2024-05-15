extends Node2D

const FLYING_ENEMY = preload("res://scenes/FlyingEnemy.tscn")

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		var flyingEnemy = FLYING_ENEMY.instantiate()
		flyingEnemy.global_position.x = global_position.x
		flyingEnemy.global_position.y = global_position.y - 100
		flyingEnemy.nextPosition = body.position
		flyingEnemy.name = "FlyingEnemy"
		get_parent().get_parent().add_child(flyingEnemy)
		queue_free()
