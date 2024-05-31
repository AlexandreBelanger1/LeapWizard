extends Node2D
@onready var open_text = $OpenText

const SWORD_PICKUP = preload("res://scenes/items/sword_pickup.tscn")
const BEEHIVE_PICKUP = preload("res://scenes/items/beehive_pickup.tscn")
const STAFF_PICKUP = preload("res://scenes/items/staff_pickup.tscn")

var RNG = RandomNumberGenerator.new()
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
	var rand = RNG.randf_range(0.0, 3.0)
	if rand <=1:
		item = SWORD_PICKUP.instantiate()
	elif rand >1 and rand <=2:
		item = BEEHIVE_PICKUP.instantiate()
	elif rand > 2:
		item = STAFF_PICKUP.instantiate()
	get_parent().get_parent().add_child(item)
	item.global_position.x = global_position.x + 24
	item.global_position.y = global_position.y + 16
	queue_free()
