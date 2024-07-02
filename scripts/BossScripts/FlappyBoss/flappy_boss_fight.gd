extends Node2D
@onready var game_manager = $".."
@onready var state_timer = $StateTimer
@onready var flappy_boss = $FlappyBoss
@onready var startup_timer = $StartupTimer
@onready var right_timer = $RightTimer
@onready var left_timer = $LeftTimer



const PIPE_1 = preload("res://scenes/BossFightObjects/FlappyBoss/pipe_1.tscn")
const PIPE_2 = preload("res://scenes/BossFightObjects/FlappyBoss/pipe_2.tscn")
const PIPE_3 = preload("res://scenes/BossFightObjects/FlappyBoss/pipe_3.tscn")
const PIPE_4 = preload("res://scenes/BossFightObjects/FlappyBoss/pipe_4.tscn")
const PIPE_5 = preload("res://scenes/BossFightObjects/FlappyBoss/pipe_5.tscn")

var difficulty = 0
#boss fight state machine
var RNG = RandomNumberGenerator.new()
var state = 0
var finalState = 3

func changeState(value: int):
	state = value
	if state == -1:
		state_timer.stop()
		stopAll()
	elif state == 0:
		state_timer.wait_time = 3
		state_timer.start()
		stopAll()
	elif state == 1:
		state_timer.wait_time = 15
		state_timer.start()
		stopAll()
		pipesFromRight(difficulty)
	elif state == 2:
		state_timer.wait_time = 3
		state_timer.start()
		stopAll()

	elif state == 3:
		state_timer.wait_time = 15
		state_timer.start()
		stopAll()
		pipesFromLeft(difficulty)



func endFight():
	changeState(-1)





func pipesFromRight(value: int):
	if value == 0:
		right_timer.wait_time = 2
		right_timer.start()
	elif value == 1:
		right_timer.wait_time = 1.5
		right_timer.start()
	elif value >= 2:
		right_timer.wait_time = 1
		right_timer.start()

func pipesFromLeft(value: int):
	if value == 0:
		left_timer.wait_time = 2
		left_timer.start()
	elif value == 1:
		left_timer.wait_time = 1.5
		left_timer.start()
	elif value >= 2:
		left_timer.wait_time = 1
		left_timer.start()

func stopAll():
	right_timer.stop()
	left_timer.stop()

func _on_startup_timer_timeout():
	difficulty = game_manager.get_world_number()
	changeState(0)




func _on_right_timer_timeout():
	var pipeSelect = int(RNG.randf_range(1,5.99))
	var pipePATH = PIPE_1
	if pipeSelect == 1:
		pipePATH = PIPE_1
	elif pipeSelect == 2:
		pipePATH = PIPE_2
	elif pipeSelect == 3:
		pipePATH = PIPE_3
	elif pipeSelect == 4:
		pipePATH = PIPE_4
	elif pipeSelect == 5:
		pipePATH = PIPE_5
	var pipe = pipePATH.instantiate()
	add_child(pipe)
	pipe.global_position.y = global_position.y
	pipe.global_position.x = global_position.x + 208
	pipe.velocity = Vector2(-1,0)
	if difficulty == 0:
		pipe.setSpeed(150)
	elif difficulty == 1:
		pipe.setSpeed(180)
	elif difficulty == 2:
		pipe.setSpeed(200)


func _on_left_timer_timeout():
	var pipeSelect = int(RNG.randf_range(1,5.99))
	var pipePATH = PIPE_1
	if pipeSelect == 1:
		pipePATH = PIPE_1
	elif pipeSelect == 2:
		pipePATH = PIPE_2
	elif pipeSelect == 3:
		pipePATH = PIPE_3
	elif pipeSelect == 4:
		pipePATH = PIPE_4
	elif pipeSelect == 5:
		pipePATH = PIPE_5
	var pipe = pipePATH.instantiate()
	add_child(pipe)
	pipe.global_position.y = global_position.y
	pipe.global_position.x = global_position.x - 208
	pipe.velocity = Vector2(1,0)
	if difficulty == 0:
		pipe.setSpeed(150)
	elif difficulty == 1:
		pipe.setSpeed(180)
	elif difficulty == 2:
		pipe.setSpeed(200)


func _on_state_timer_timeout():
	if state != finalState:
		changeState(state+1) 
	else:
		changeState(0)
