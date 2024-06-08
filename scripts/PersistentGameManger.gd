extends Node

func _ready():
	if not FileAccess.file_exists("user://savegame.tres"):
		save_game()
	else:
		load_game()
#Save and Load game handling
func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_upgrade_currency = player_upgrade_currency
	saved_game.companion_upgrade_currency = companion_upgrade_currency
	for i in player_loadout_array.size():
		saved_game.player_loadout_array.append(player_loadout_array[i])
	for i in companion_loadout_array.size():
		saved_game.companion_loadout_array.append(companion_loadout_array[i])
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	if not FileAccess.file_exists("user://savegame.tres"):
		print_debug("No save file/ file is corrupted!")
		return
	print_debug("loading save")
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	player_upgrade_currency = saved_game.player_upgrade_currency
	companion_upgrade_currency = saved_game.companion_upgrade_currency
	for i in player_loadout_array.size():
		player_loadout_array[i] = saved_game.player_loadout_array[i]
	for i in companion_loadout_array.size():
		companion_loadout_array[i] = saved_game.companion_loadout_array[i]

func new_save():
	player_upgrade_currency = 0
	companion_upgrade_currency = 0
	player_loadout_array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
	companion_loadout_array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
	save_game()


#save and load game variables
var player_upgrade_currency = 0
var companion_upgrade_currency = 0
var player_loadout_array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
var companion_loadout_array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

#Setters and Getters for save game components
#Setters

func set_player_upgrade_currency(value:int):
	player_upgrade_currency = value

func set_companion_upgrade_currency(value:int):
	companion_upgrade_currency = value

func set_player_loadout_array(index:int, value:bool):
	player_loadout_array[index] = value

func set_companion_loadout_array(index:int, value:bool):
	companion_loadout_array[index] = value

#Getters

func get_player_upgrade_currency():
	return player_upgrade_currency

func get_companion_upgrade_currency():
	return companion_upgrade_currency

func get_player_loadout_array(index:int):
	return player_loadout_array[index]

func get_companion_loadout_array(index:int):
	return companion_loadout_array[index]



#Item Updater
func setItems(playerItems):
	var playerItemsTemp = []
	for i in playerItems.size():
		playerItemsTemp.append(playerItems[i])
	playerSavedItems = playerItemsTemp

func getItems():
	return playerSavedItems

#game run variables
var playerSavedItems = []
var worldNumber = 0
var player_jump_count = 2
var player_speed
var player_jump 
var player_damage = 50
var score = 0
var HP = 6
var maxHP = 6
var maxMana = 1000
var mana = 1000
var manaCD = 0.2
var manaRate  = 10

#SpellSlot1
var slot1SpellName  = "staff"
var slot1DamageBase =30
var slot1CDBase = 0.1
var slot1CostBase = 20
var slot1Damage =1
var slot1CD = 1
var slot1Cost = 1

#SpellSlot2
var slot2SpellName  = "none"
var slot2DamageBase =0
var slot2CDBase = 20
var slot2CostBase = 0
var slot2Damage = 1
var slot2CD = 1
var slot2Cost = 1

#Spell Base Values:

#Staff
var staffDamage = 30
var staffCD = 0.1
var staffCost = 10

#Sword
var swordDamage = 120
var swordCD = 0.5
var swordCost = 50

#BeeHive
var beeDamage = 15
var beeCD = 0.1
var beeCost = 20

#Shield
var shieldDamage = 120
var shieldCD = 2
var shieldCost = 300


#SpellSlot1 Variables
func get_slot1_name():
	return slot1SpellName

func set_slot1_name(value):
	if value == "staff":
		slot1SpellName = value
		slot1DamageBase = staffDamage
		slot1CDBase = staffCD
		slot1CostBase = staffCost
	elif value == "sword":
		slot1SpellName = value
		slot1DamageBase = swordDamage
		slot1CDBase = swordCD 
		slot1CostBase = swordCost
	elif value == "beehive":
		slot1SpellName = value
		slot1DamageBase = beeDamage
		slot1CDBase = beeCD
		slot1CostBase = beeCost
	elif value == "shield":
		slot1SpellName = value
		slot1DamageBase = shieldDamage
		slot1CDBase = shieldCD
		slot1CostBase = shieldCost

#Calculated values for CD, Damage, Cost using base values and multipliers
func get_slot1_total_damage():
	return slot1Damage * slot1DamageBase

func get_slot1_total_cost():
	return slot1Cost * slot1CostBase

func get_slot1_total_CD():
	return slot1CD * slot1CDBase

func get_slot2_total_damage():
	return slot2Damage * slot2DamageBase

func get_slot2_total_cost():
	return slot2Cost * slot2CostBase

func get_slot2_total_CD():
	return slot2CD * slot2CDBase


#Slot 1 modifier variables
func get_slot1_damage():
	return slot1Damage

func set_slot1_damage(value):
	slot1Damage = value

func get_slot1_cost():
	return slot1Cost

func set_slot1_cost(value):
	slot1Cost = value

func get_slot1_CD():
	return slot1CD

func set_slot1_CD(value):
	slot1CD = value


#Slot 2 modifier variables
func get_slot2_name():
	return slot2SpellName

func set_slot2_name(value):
	if value == "staff":
		slot2SpellName = value
		slot2DamageBase = staffDamage
		slot2CDBase = staffCD
		slot2CostBase = staffCost
	elif value == "sword":
		slot2SpellName = value
		slot2DamageBase = swordDamage
		slot2CDBase = swordCD 
		slot2CostBase = swordCost
	elif value == "beehive":
		slot2SpellName = value
		slot2DamageBase = beeDamage
		slot2CDBase = beeCD
		slot2CostBase = beeCost
	elif value == "shield":
		slot2SpellName = value
		slot2DamageBase = shieldDamage
		slot2CDBase = shieldCD
		slot2CostBase = shieldCost

func get_slot2_damage():
	return slot2Damage

func set_slot2_damage(value):
	slot2Damage = value

func get_slot2_cost():
	return slot2Cost

func set_slot2_cost(value):
	slot2Cost = value

func get_slot2_CD():
	return slot2CD

func set_slot2_CD(value):
	slot2CD = value



#Player mana varaibles

func get_player_max_mana():
	return  maxMana

func set_player_max_mana(value):
	maxMana = value

func get_player_mana_CD():
	return manaCD

func get_player_mana_rate():
	return manaRate

func set_player_mana_CD(value):
	manaCD = value

func set_player_mana_rate(value):
	manaRate = value


func get_player_mana():
	return mana

func set_player_mana(value):
	mana = value
	if mana > maxMana:
		mana = maxMana

func remove_player_mana(value):
	mana -= value
	if mana < 0:
		mana = 0

func add_player_mana(value):
	mana += value
	if mana > maxMana:
		mana = maxMana



func add_player_damage(value):
	player_damage += value

func remove_points(value):
	score -= value

func add_point():
	score += 1

func changeHealth(Value):
	HP += Value

func addJumps(Value):
	player_jump_count += Value

func get_player_damage():
	return player_damage

func get_player_jumps():
	return player_jump_count

func get_player_speed():
	return player_speed

func get_player_score():
	return score

func get_player_HP():
	return HP

func get_player_maxHP():
	return maxHP

func set_player_maxHP(value):
	maxHP = value


const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")
func NextWorld():
	print_debug("nextWorld() called")
	worldNumber += 1
	var world = GAME_SCENE_2.instantiate()
	add_child(world)
