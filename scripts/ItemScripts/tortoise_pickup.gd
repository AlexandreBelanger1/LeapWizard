extends Node2D
const TORTOISE = preload("res://scenes/tortoise.tscn")

func _on_hitbox_body_entered(body):
	body.tortoisePickup()
	call_deferred("free")
