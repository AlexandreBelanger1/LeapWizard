extends Node2D

const FLYING_ENEMY = preload("res://scenes/FlyingEnemy.tscn")




func _on_visible_on_screen_notifier_2d_screen_entered():
	var flyingEnemy = FLYING_ENEMY.instantiate()
	get_parent().add_child(flyingEnemy)
	flyingEnemy.global_position.x = global_position.x
	flyingEnemy.global_position.y = global_position.y - 32
	flyingEnemy.nextPosition.y = global_position.y 
	flyingEnemy.nextPosition.x = global_position.x - 5
	flyingEnemy.name = "FlyingEnemy"
	queue_free()
