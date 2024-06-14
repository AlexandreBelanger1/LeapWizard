extends Node2D
@onready var open_text = $OpenText

const SWORD_PICKUP = preload("res://scenes/items/sword_pickup.tscn")
const BEEHIVE_PICKUP = preload("res://scenes/items/beehive_pickup.tscn")
const STAFF_PICKUP = preload("res://scenes/items/staff_pickup.tscn")
const TORTOISE_PICKUP = preload("res://scenes/items/tortoise_pickup.tscn")
const SHIELD_PICKUP = preload("res://scenes/items/shield_pickup.tscn")
const SEAGULL_SUMMONER = preload("res://scenes/items/seagull_summoner.tscn")
const EXTRA_JUMP_PICKUP = preload("res://scenes/items/extra_jump_pickup.tscn")
const RMB_DAMAGE_PICKUP = preload("res://scenes/items/RMB_damage_pickup.tscn")
const LMB_DAMAGE_PICKUP = preload("res://scenes/items/LMB_damage_pickup.tscn")
const HEART_CONTAINER_PICKUP = preload("res://scenes/items/heart_container_pickup.tscn")

var RNG = RandomNumberGenerator.new()
var insideRange = false
var item
var item2

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
	var extraDrop = RNG.randf_range(0,10)
	var rand = RNG.randf_range(0.0, 10.0)
	if rand <=1:
		item = SWORD_PICKUP.instantiate()
	elif rand >1 and rand <=2:
		item = BEEHIVE_PICKUP.instantiate()
	elif rand > 2 and rand <=3:
		item = STAFF_PICKUP.instantiate()
	elif rand > 3 and rand <=4:
		item = SHIELD_PICKUP.instantiate()
	elif rand > 4 and rand <=5:
		item = TORTOISE_PICKUP.instantiate()
	elif rand > 5 and rand <=6:
		item = SEAGULL_SUMMONER.instantiate()
	elif rand > 6 and rand <=7:
		item = EXTRA_JUMP_PICKUP.instantiate()
	elif rand > 7 and rand <=8:
		item = RMB_DAMAGE_PICKUP.instantiate()
	elif rand > 8 and rand <=9:
		item = LMB_DAMAGE_PICKUP.instantiate()
	elif rand > 9 and rand <=10:
		item = HEART_CONTAINER_PICKUP.instantiate()
	get_parent().get_parent().add_child(item)
	item.global_position.x = global_position.x + 24
	item.global_position.y = global_position.y 
	if extraDrop > 8.5:
		var rand2 = RNG.randf_range(0.0, 10.0)
		if rand2 <=1:
			item2 = SWORD_PICKUP.instantiate()
		elif rand2 >1 and rand <=2:
			item2 = BEEHIVE_PICKUP.instantiate()
		elif rand2 > 2 and rand <=3:
			item2 = STAFF_PICKUP.instantiate()
		elif rand2 > 3 and rand <=4:
			item2 = SHIELD_PICKUP.instantiate()
		elif rand2 > 4 and rand <=5:
			item2 = TORTOISE_PICKUP.instantiate()
		elif rand2 > 5 and rand <=6:
			item2 = SEAGULL_SUMMONER.instantiate()
		elif rand2 > 6 and rand <=7:
			item2 = EXTRA_JUMP_PICKUP.instantiate()
		elif rand2 > 7 and rand <=8:
			item2 = RMB_DAMAGE_PICKUP.instantiate()
		elif rand2 > 8 and rand <=9:
			item2 = LMB_DAMAGE_PICKUP.instantiate()
		elif rand2 > 9 and rand <=10:
			item2 = HEART_CONTAINER_PICKUP.instantiate()
		else:
			item2 = HEART_CONTAINER_PICKUP.instantiate()
		get_parent().get_parent().add_child(item2)
		item2.global_position.x = global_position.x + 45
		item2.global_position.y = global_position.y 
	queue_free()
