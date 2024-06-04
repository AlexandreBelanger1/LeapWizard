extends Node2D
@onready var game_manager = $".."
@onready var info_button = $InfoButton
@onready var info_panel = $InfoPanel
@onready var info_button_close = $InfoButtonClose
@onready var buy_label = $BuyLabel
@onready var item_sprite = $ItemSprite
@onready var info_label = $InfoPanel/InfoLabel
@onready var price_label = $PriceLabel


const HEART_PICKUP = preload("res://scenes/items/heart_pickup.tscn")
const HALF_HEART_PICKUP = preload("res://scenes/items/half_heart_pickup.tscn")
const HEART_CONTAINER_PICKUP = preload("res://scenes/items/heart_container_pickup.tscn")
const LMB_COOLDOWN_PICKUP = preload("res://scenes/items/LMB_cooldown_pickup.tscn")
const LMB_DAMAGE_PICKUP = preload("res://scenes/items/LMB_damage_pickup.tscn")
const LMB_COST_PICKUP = preload("res://scenes/items/LMB_cost_pickup.tscn")
const RMB_COOLDOWN_PICKUP = preload("res://scenes/items/RMB_cooldown_pickup.tscn")
const RMB_DAMAGE_PICKUP = preload("res://scenes/items/RMB_damage_pickup.tscn")
const RMB_COST_PICKUP = preload("res://scenes/items/RMB_cost_pickup.tscn")
const EXTRA_JUMP_PICKUP = preload("res://scenes/items/extra_jump_pickup.tscn")

var ItemDict= {"HEART": 0,
"HALF_HEART": 1, 
"HEART_CONTAINER" : 2,
"LMB_COOLDOWN_ITEM" : 3,
"LMB_DAMAGE_UP_ITEM":4,
"LMB_MANA_DECREASE_ITEM" : 5,
"RMB_COOLDOWN_ITEM" : 6,
"RMB_DAMAGE_UP_ITEM" : 7,
"RMB_MANA_DECREASE_ITEM" : 8,
"EXTRA_JUMP_ITEM" : 9
}

var PriceDict= {"HEART": 10,
"HALF_HEART": 4, 
"HEART_CONTAINER" : 50,
"LMB_COOLDOWN_ITEM" : 50,
"LMB_DAMAGE_UP_ITEM":50,
"LMB_MANA_DECREASE_ITEM" : 30,
"RMB_COOLDOWN_ITEM" : 50,
"RMB_DAMAGE_UP_ITEM" : 50,
"RMB_MANA_DECREASE_ITEM" : 30,
"EXTRA_JUMP_ITEM" : 40
}

var SpriteDict= {"HEART": "res://assets/sprites/HeartPickup.png",
"HALF_HEART": "res://assets/sprites/HalfHeartPickup.png", 
"HEART_CONTAINER" : "res://assets/sprites/HeartContainerItem.png",
"LMB_COOLDOWN_ITEM" : "res://assets/sprites/LMBCooldownItem.png",
"LMB_DAMAGE_UP_ITEM":"res://assets/sprites/LMBDamageUpItem.png",
"LMB_MANA_DECREASE_ITEM" : "res://assets/sprites/LMBManaDecreaseItem.png",
"RMB_COOLDOWN_ITEM" : "res://assets/sprites/RMBCooldownItem.png",
"RMB_DAMAGE_UP_ITEM" : "res://assets/sprites/RMBDamageUpItem.png",
"RMB_MANA_DECREASE_ITEM" : "res://assets/sprites/RMBManaDecreaseItem.png",
"EXTRA_JUMP_ITEM" :"res://assets/sprites/ExtraJumpItem.png"
}

var DescriptionsDict = {"HEART": "Restore 1 Heart",
"HALF_HEART": "Restore 1/2 Heart", 
"HEART_CONTAINER" : "+1 Maximum Hearts",
"LMB_COOLDOWN_ITEM" : "-10% Cooldown on spell slot 1",
"LMB_DAMAGE_UP_ITEM":"+10% Damage on spell slot 1",
"LMB_MANA_DECREASE_ITEM" : "-10% Mana cost on spell slot 1",
"RMB_COOLDOWN_ITEM" : "-10% Cooldown on spell slot 2",
"RMB_DAMAGE_UP_ITEM" : "+10% Damage on spell slot 2",
"RMB_MANA_DECREASE_ITEM" : "-10% Mana cost on spell slot 2",
"EXTRA_JUMP_ITEM" :"+1 Mid-air jumps"}


var itemName = "test"
var insideRange = false

var heartCost = 10
var halfHeartCost = 4
var heartContainerCost = 50
var lmbCooldownCost = 50
var lmbDamageCost =  50
var lmbManaCost = 30
var rmbCooldownCost = 50
var rmbDamageCost =  50
var rmbManaCost = 30
var extraJumpCost = 40


func _on_item_area_body_entered(_body):
	#info_button.visible = true
	#buy_label.visible = true
	insideRange = true
	info_panel.visible = true


func _on_item_area_body_exited(_body):
	info_button.visible = false
	info_panel.visible = false
	info_button_close.visible = false
	buy_label.visible = false
	insideRange = false


func _on_info_button_pressed():
	info_panel.visible = true
	info_button.visible = false
	info_button_close.visible = true


func _on_info_button_close_pressed():
	info_panel.visible = false
	info_button.visible = true
	info_button_close.visible = false


func _input(event):
	if event.is_action_pressed("Interact") and insideRange:
		buyItem(itemName)


func buyItem(name1):
	var playerEggs = game_manager.get_player_score()
	if ItemDict[name1] == 0:
		if playerEggs >= heartCost:
			generateHeart()
			queue_free()
	elif ItemDict[name1] == 1:
		if playerEggs >= halfHeartCost:
			generateHalfHeart()
			queue_free()
	elif ItemDict[name1] == 2:
		if playerEggs >= heartContainerCost:
			generateHeartContainer()
			queue_free()
	elif ItemDict[name1] == 3:
		if playerEggs >= lmbCooldownCost:
			generateLMBCooldown()
			queue_free()
	elif ItemDict[name1] == 4:
		if playerEggs >= lmbDamageCost:
			generateLMBDamage()
			queue_free()
	elif ItemDict[name1] == 5:
		if playerEggs >= lmbManaCost:
			generateLMBMana()
			queue_free()
	elif ItemDict[name1] == 6:
		if playerEggs >= rmbCooldownCost:
			generateRMBCooldown()
			queue_free()
	elif ItemDict[name1] == 7:
		if playerEggs >= rmbDamageCost:
			generateRMBDamage()
			queue_free()
	elif ItemDict[name1] == 8:
		if playerEggs >= rmbManaCost:
			generateRMBMana()
			queue_free()
	elif ItemDict[name1] == 9:
		if playerEggs >= extraJumpCost:
			generateExtraJump()
			queue_free()
	


func instantiateItem(name1):
	itemName = name1
	info_label.text = DescriptionsDict[name1]
	item_sprite.texture = load(SpriteDict[name1])
	price_label.text = str(PriceDict[name1])


func generateHeart():
	game_manager.remove_points(heartCost)
	var generatedItem = HEART_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateHalfHeart():
	game_manager.remove_points(halfHeartCost)
	var generatedItem = HALF_HEART_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateHeartContainer():
	game_manager.remove_points(heartContainerCost)
	var generatedItem = HEART_CONTAINER_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateLMBCooldown():
	game_manager.remove_points(lmbCooldownCost)
	var generatedItem = LMB_COOLDOWN_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateLMBDamage():
	game_manager.remove_points(lmbDamageCost)
	var generatedItem = LMB_DAMAGE_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateLMBMana():
	game_manager.remove_points(lmbManaCost)
	var generatedItem = LMB_COST_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateRMBCooldown():
	game_manager.remove_points(rmbCooldownCost)
	var generatedItem = RMB_COOLDOWN_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateRMBDamage():
	game_manager.remove_points(rmbDamageCost)
	var generatedItem = RMB_DAMAGE_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateRMBMana():
	game_manager.remove_points(rmbManaCost)
	var generatedItem = RMB_COST_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position

func generateExtraJump():
	game_manager.remove_points(extraJumpCost)
	var generatedItem = EXTRA_JUMP_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position = global_position
