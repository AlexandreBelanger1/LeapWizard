extends Node2D


func _on_hitbox_body_entered(body):
	body.takeDamage()
