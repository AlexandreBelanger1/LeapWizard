extends Node2D

@onready var activate_boss = $ActivateBoss
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


var playerInSpawnerFlag = false


func _on_area_2d_body_entered(_body):
	playerInSpawnerFlag = true
	activate_boss.visible = true
func _on_area_2d_body_exited(_body):
	playerInSpawnerFlag = false
	activate_boss.visible = false
		
		
func _input(event):
	if event.is_action_pressed("Interact") and playerInSpawnerFlag:
		generateHeart()
		generateHalfHeart()
		generateHeartContainer()
		generateHeartContainer()
		generateLMBCooldown()
		generateLMBDamage()
		generateLMBMana()
		generateRMBCooldown()
		generateRMBDamage()
		generateRMBMana()
		generateExtraJump()


func generateHeart():

	var generatedItem = HEART_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 16
	generatedItem.global_position.y = global_position.y - 8

func generateHalfHeart():

	var generatedItem = HALF_HEART_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 32
	generatedItem.global_position.y = global_position.y - 8

func generateHeartContainer():

	var generatedItem = HEART_CONTAINER_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 48
	generatedItem.global_position.y = global_position.y - 8

func generateLMBCooldown():

	var generatedItem = LMB_COOLDOWN_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 64
	generatedItem.global_position.y = global_position.y - 8

func generateLMBDamage():

	var generatedItem = LMB_DAMAGE_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 80
	generatedItem.global_position.y = global_position.y - 8

func generateLMBMana():

	var generatedItem = LMB_COST_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 96
	generatedItem.global_position.y = global_position.y - 8

func generateRMBCooldown():

	var generatedItem = RMB_COOLDOWN_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 112
	generatedItem.global_position.y = global_position.y - 8

func generateRMBDamage():

	var generatedItem = RMB_DAMAGE_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 128
	generatedItem.global_position.y = global_position.y - 8

func generateRMBMana():

	var generatedItem = RMB_COST_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 144
	generatedItem.global_position.y = global_position.y - 8

func generateExtraJump():

	var generatedItem = EXTRA_JUMP_PICKUP.instantiate()
	get_parent().add_child(generatedItem)
	generatedItem.global_position.x = global_position.x + 160
	generatedItem.global_position.y = global_position.y - 8
