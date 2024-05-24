extends Node2D
const SHOP_ITEM = preload("res://scenes/shop_item.tscn")
var ItemsInShop = []

var item1
var item2
var item3
var item4
var item5

func _ready():
	populateShop()

func populateShop():
	var rng = RandomNumberGenerator.new()
	var shopSize = int(rng.randf_range(3.0, 4.99))
	for item in shopSize:
		var newItem = SHOP_ITEM.instantiate()
		get_parent().get_parent().add_child(newItem)
		newItem.global_position.y = global_position.y 
		newItem.global_position.x = global_position.x - (32*item + 32) 
		var randomItem = int(rng.randf_range(0.0, 9.99))
		if randomItem == 0:
			newItem.instantiateItem("HEART")
		elif randomItem == 1:
			newItem.instantiateItem("HALF_HEART")
		elif randomItem == 2:
			newItem.instantiateItem("HEART_CONTAINER")
		elif randomItem == 3:
			newItem.instantiateItem("LMB_COOLDOWN_ITEM")
		elif randomItem == 4:
			newItem.instantiateItem("LMB_DAMAGE_UP_ITEM")
		elif randomItem == 5:
			newItem.instantiateItem("LMB_MANA_DECREASE_ITEM")
		elif randomItem == 6:
			newItem.instantiateItem("RMB_COOLDOWN_ITEM")
		elif randomItem == 7:
			newItem.instantiateItem("RMB_DAMAGE_UP_ITEM")
		elif randomItem == 8:
			newItem.instantiateItem("RMB_MANA_DECREASE_ITEM")
		elif randomItem == 9:
			newItem.instantiateItem("EXTRA_JUMP_ITEM")
		
		
