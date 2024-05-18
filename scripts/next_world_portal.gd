extends Node2D


@onready var next_world_button = $NextWorldButton

const GAME_SCENE_3 = preload("res://scenes/GameScene2.tscn")

var playerInPortal = false


func _on_teleport_zone_body_entered(body):
	next_world_button.visible = true
	playerInPortal =  true

func _on_teleport_zone_body_exited(body):
	next_world_button.visible = false
	playerInPortal = false

func _on_next_world_button_pressed():
	var GameScene3 = GAME_SCENE_3.instantiate()
	get_parent().get_parent().add_child(GameScene3)
	get_parent().queue_free()
