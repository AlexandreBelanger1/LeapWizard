extends Node

var player_jump_count = 2
var player_speed
var player_jump 
var player_damage = 5
var score = 0
var HP = 4

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


