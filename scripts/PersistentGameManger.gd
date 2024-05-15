extends Node

var player_jump_count = 2
var player_speed
var player_jump 
var player_damage = 5
var score = 0
var HP = 4
var maxMana = 100
var mana = 50
var manaCD = 1
var manaRate  = 1

#SpellSlot1
var slot1Damage =5
var slot1CD = 3
var slot1Cost = 3

#SpellSlot2
var slot2Damage = 0
var slot2CD = 2
var slot2Cost = 200


#SpellSlot1 Variables
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


