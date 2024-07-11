extends Node2D
@onready var game_manager = $".."
@onready var boss_music_intro = $BossMusicIntro
@onready var boss_music_continuous = $BossMusicContinuous

@onready var computer_turret_rhs = $ComputerTurretRHS
@onready var computer_turret_rhs_2 = $ComputerTurretRHS2
@onready var computer_turret_rhs_3 = $ComputerTurretRHS3
@onready var computer_turret_rhs_4 = $ComputerTurretRHS4
@onready var computer_turret_rhs_5 = $ComputerTurretRHS5
@onready var computer_turret_rhs_6 = $ComputerTurretRHS6
@onready var computer_turret_rhs_7 = $ComputerTurretRHS7
@onready var computer_turret_top = $ComputerTurretTOP
@onready var computer_turret_top_2 = $ComputerTurretTOP2
@onready var computer_turret_top_3 = $ComputerTurretTOP3
@onready var computer_turret_top_4 = $ComputerTurretTOP4
@onready var computer_turret_top_5 = $ComputerTurretTOP5
@onready var computer_turret_top_6 = $ComputerTurretTOP6
@onready var computer_turret_top_7 = $ComputerTurretTOP7
@onready var computer_turret_top_8 = $ComputerTurretTOP8
@onready var computer_turret_top_9 = $ComputerTurretTOP9
@onready var computer_turret_top_10 = $ComputerTurretTOP10
@onready var computer_turret_top_11 = $ComputerTurretTOP11
@onready var computer_turret_top_12 = $ComputerTurretTOP12
@onready var computer_turret_top_13 = $ComputerTurretTOP13
@onready var computer_turret_top_14 = $ComputerTurretTOP14
@onready var computer_turret_top_15 = $ComputerTurretTOP15
@onready var computer_turret_top_16 = $ComputerTurretTOP16
@onready var computer_turret_top_17 = $ComputerTurretTOP17
@onready var computer_turret_top_18 = $ComputerTurretTOP18
@onready var computer_turret_top_19 = $ComputerTurretTOP19
@onready var computer_turret_top_20 = $ComputerTurretTOP20
@onready var computer_turret_top_21 = $ComputerTurretTOP21
@onready var computer_turret_top_22 = $ComputerTurretTOP22
@onready var computer_turret_lhs = $ComputerTurretLHS
@onready var computer_turret_lhs_2 = $ComputerTurretLHS2
@onready var computer_turret_lhs_3 = $ComputerTurretLHS3
@onready var computer_turret_lhs_4 = $ComputerTurretLHS4
@onready var computer_turret_lhs_5 = $ComputerTurretLHS5
@onready var computer_turret_lhs_6 = $ComputerTurretLHS6
@onready var computer_turret_lhs_7 = $ComputerTurretLHS7

@onready var computer_boss = $ComputerBoss

@onready var tentacles = $Tentacles
@onready var shoot_at_player = $ShootAtPlayer
@onready var raining_floppies = $RainingFloppies


@onready var state_timer = $StateTimer

var allTurrets = []
var middleOpen = []
var topRight = []
var botRight = []
var topLeft = []
var botLeft = []

var difficulty = 0
#boss fight state machine

var state = 4
var finalState = 6

func changeState(value: int):
	state = value
	if state == -1:
		state_timer.stop()
		stopAll()
	elif state == 0:
		state_timer.wait_time = 1.5
		state_timer.start()
		stopAll()
	elif state == 1:
		state_timer.wait_time = 5.3
		state_timer.start()
		stopAll()
		shoot_at_player.play(difficulty)
		unpauseTurrets(topRight)
	elif state == 2:
		state_timer.wait_time = 5.3
		state_timer.start()
		stopAll()
		shoot_at_player.play(difficulty)
		unpauseTurrets(botRight)
	elif state == 3:
		state_timer.wait_time = 5.3
		state_timer.start()
		stopAll()
		shoot_at_player.play(difficulty)
		unpauseTurrets(botLeft)
	elif state == 4:
		state_timer.wait_time = 5.3
		state_timer.start()
		stopAll()
		shoot_at_player.play(difficulty)
		unpauseTurrets(topLeft)
	elif state == 5:
		state_timer.wait_time = 8
		state_timer.start()
		stopAll()
		raining_floppies.play(difficulty)
		unpauseTurrets(middleOpen)
	elif state == 6:
		state_timer.wait_time = 15
		state_timer.start()
		stopAll()
		tentacles.play(difficulty)

func endFight():
	changeState(-1)

func stopAll():
	pauseTurrets(allTurrets)
	tentacles.pause()
	shoot_at_player.pause()
	raining_floppies.pause()

func unpauseTurrets(turretArray):
	for i in turretArray:
		i.pauseTurret(false)

func pauseTurrets(turretArray):
	for i in turretArray:
		i.pauseTurret(true)


func _on_state_change_timeout():
	if state != finalState:
		changeState(state+1) 
	else:
		changeState(0)





func _on_startup_timer_timeout():
	boss_music_intro.play()
	difficulty = game_manager.get_world_number()
	
	allTurrets.append_array([
	computer_turret_rhs,
	computer_turret_rhs_2,
	computer_turret_rhs_3,
	computer_turret_rhs_4,
	computer_turret_rhs_5,
	computer_turret_rhs_6,
	computer_turret_rhs_7,
	computer_turret_top,
	computer_turret_top_2,
	computer_turret_top_3,
	computer_turret_top_4,
	computer_turret_top_5,
	computer_turret_top_6,
	computer_turret_top_7,
	computer_turret_top_8,
	computer_turret_top_9,
	computer_turret_top_10,
	computer_turret_top_11,
	computer_turret_top_12,
	computer_turret_top_13,
	computer_turret_top_14,
	computer_turret_top_15,
	computer_turret_top_16,
	computer_turret_top_17,
	computer_turret_top_18,
	computer_turret_top_19,
	computer_turret_top_20,
	computer_turret_top_21,
	computer_turret_top_22,
	computer_turret_lhs,
	computer_turret_lhs_2,
	computer_turret_lhs_3,
	computer_turret_lhs_4,
	computer_turret_lhs_5,
	computer_turret_lhs_6,
	computer_turret_lhs_7
	])
	
	topRight.append_array([
	computer_turret_rhs,
	computer_turret_rhs_2,
	computer_turret_rhs_3,
	computer_turret_rhs_4,
	#computer_turret_rhs_5,
	#computer_turret_rhs_6,
	#computer_turret_rhs_7,
	#computer_turret_top,
	#computer_turret_top_2,
	#computer_turret_top_3,
	#computer_turret_top_4,
	#computer_turret_top_5,
	#computer_turret_top_6,
	#computer_turret_top_7,
	#computer_turret_top_8,
	#computer_turret_top_9,
	#computer_turret_top_10,
	#computer_turret_top_11,
	computer_turret_top_12,
	computer_turret_top_13,
	computer_turret_top_14,
	computer_turret_top_15,
	computer_turret_top_16,
	computer_turret_top_17,
	computer_turret_top_18,
	computer_turret_top_19,
	computer_turret_top_20,
	computer_turret_top_21,
	computer_turret_top_22,
	computer_turret_lhs,
	computer_turret_lhs_2,
	computer_turret_lhs_3,
	#computer_turret_lhs_4,
	#computer_turret_lhs_5
	#computer_turret_lhs_6,
	#computer_turret_lhs_7
	])
	botRight.append_array([
	#computer_turret_rhs,
	#computer_turret_rhs_2,
	#computer_turret_rhs_3,
	#computer_turret_rhs_4,
	computer_turret_rhs_5,
	computer_turret_rhs_6,
	computer_turret_rhs_7,
	#computer_turret_top,
	#computer_turret_top_2,
	#computer_turret_top_3,
	#computer_turret_top_4,
	#computer_turret_top_5,
	#computer_turret_top_6,
	#computer_turret_top_7,
	#computer_turret_top_8,
	#computer_turret_top_9,
	#computer_turret_top_10,
	#computer_turret_top_11,
	computer_turret_top_12,
	computer_turret_top_13,
	computer_turret_top_14,
	computer_turret_top_15,
	computer_turret_top_16,
	computer_turret_top_17,
	computer_turret_top_18,
	computer_turret_top_19,
	computer_turret_top_20,
	computer_turret_top_21,
	computer_turret_top_22,
	#computer_turret_lhs,
	#computer_turret_lhs_2,
	#computer_turret_lhs_3,
	computer_turret_lhs_4,
	computer_turret_lhs_5,
	computer_turret_lhs_6,
	computer_turret_lhs_7
	])
	
	topLeft.append_array([
	computer_turret_rhs,
	computer_turret_rhs_2,
	computer_turret_rhs_3,
	computer_turret_rhs_4,
	#computer_turret_rhs_5,
	#computer_turret_rhs_6,
	#computer_turret_rhs_7,
	computer_turret_top,
	computer_turret_top_2,
	computer_turret_top_3,
	computer_turret_top_4,
	computer_turret_top_5,
	computer_turret_top_6,
	computer_turret_top_7,
	computer_turret_top_8,
	computer_turret_top_9,
	computer_turret_top_10,
	computer_turret_top_11,
	#computer_turret_top_12,
	#computer_turret_top_13,
	#computer_turret_top_14,
	#computer_turret_top_15,
	#computer_turret_top_16,
	#computer_turret_top_17,
	#computer_turret_top_18,
	#computer_turret_top_19,
	#computer_turret_top_20,
	#computer_turret_top_21,
	#computer_turret_top_22,
	computer_turret_lhs,
	computer_turret_lhs_2,
	computer_turret_lhs_3,
	#computer_turret_lhs_4,
	#computer_turret_lhs_5,
	#computer_turret_lhs_6,
	#computer_turret_lhs_7
	])
	
	botLeft.append_array([
	#computer_turret_rhs,
	#computer_turret_rhs_2,
	#computer_turret_rhs_3,
	#computer_turret_rhs_4,
	computer_turret_rhs_5,
	computer_turret_rhs_6,
	computer_turret_rhs_7,
	computer_turret_top,
	computer_turret_top_2,
	computer_turret_top_3,
	computer_turret_top_4,
	computer_turret_top_5,
	computer_turret_top_6,
	computer_turret_top_7,
	computer_turret_top_8,
	computer_turret_top_9,
	computer_turret_top_10,
	computer_turret_top_11,
	#computer_turret_top_12,
	#computer_turret_top_13,
	#computer_turret_top_14,
	#computer_turret_top_15,
	#computer_turret_top_16,
	#computer_turret_top_17,
	#computer_turret_top_18,
	#computer_turret_top_19,
	#computer_turret_top_20,
	#computer_turret_top_21,
	#computer_turret_top_22,
	#computer_turret_lhs,
	#computer_turret_lhs_2,
	#computer_turret_lhs_3,
	computer_turret_lhs_4,
	computer_turret_lhs_5,
	computer_turret_lhs_6,
	computer_turret_lhs_7
	])
	
	middleOpen.append_array([
	computer_turret_top,
	computer_turret_top_2,
	computer_turret_top_3,
	computer_turret_top_4,
	computer_turret_top_5,
	computer_turret_top_6,
	computer_turret_top_7,
	computer_turret_top_8,
	computer_turret_top_9,
	#computer_turret_top_10,
	#computer_turret_top_11,
	#computer_turret_top_12,
	#computer_turret_top_13,
	computer_turret_top_14,
	computer_turret_top_15,
	computer_turret_top_16,
	computer_turret_top_17,
	computer_turret_top_18,
	computer_turret_top_19,
	computer_turret_top_20,
	computer_turret_top_21,
	computer_turret_top_22
	])



func _on_boss_music_intro_finished():
	boss_music_continuous.play()


func _on_boss_music_continuous_finished():
	boss_music_continuous.play()
