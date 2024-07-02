extends Node2D
@onready var open_text = $OpenText
@onready var tutorial = $".."

const SWORD_PICKUP = preload("res://scenes/items/sword_pickup.tscn")


var insideRange = false
var item


func _on_area_2d_body_entered(_body):
	open_text.visible = true
	insideRange = true

func _on_area_2d_body_exited(_body):
	open_text.visible = false
	insideRange = false

func _input(event):
	if event.is_action_pressed("Interact") and insideRange:
		openChest()

func openChest():

	item = SWORD_PICKUP.instantiate()
	get_parent().add_child(item)
	item.global_position.x = global_position.x + 24
	item.global_position.y = global_position.y 
	tutorial.openChest()
	queue_free()
