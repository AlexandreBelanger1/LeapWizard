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
	print_debug(player_upgrade_currency)
	print_debug(saved_game.player_upgrade_currency)
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







#game run variables
var player_jump_count = 2
var player_speed
var player_jump 
var player_damage = 5
var score = 0
var HP = 6
var maxHP = 6
var maxMana = 100
var mana = 50
var manaCD = 0.2
var manaRate  = 1

#SpellSlot1
var slot1SpellName  = "staff"
var slot1Damage =3
var slot1CD = 0.1
var slot1Cost = 2

#SpellSlot2
var slot2SpellName  = "sword"
var slot2Damage = 15
var slot2CD = 0.5
var slot2Cost = 5


#SpellSlot1 Variables
func get_slot1_name():
	return slot1SpellName

func set_slot1_name(value):
	slot1SpellName = value

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


#SpellSlot2 Variables
func get_slot2_name():
	return slot2SpellName

func set_slot2_name(value):
	slot2SpellName = value

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

