extends Node2D

@onready var timer = $Timer

@onready var player = $"../../Player"

const FLOPPY_DISK = preload("res://scenes/floppyDisk.tscn")
var difficulty = 0
var RNG = RandomNumberGenerator.new()
func pause():
	timer.stop()

func play(value: int):
	difficulty = value
	if difficulty == 0:
		timer.wait_time = 1.0
	elif difficulty == 1:
		timer.wait_time = 0.75
	elif difficulty >= 2:
		timer.wait_time = 0.5
	timer.start()

func _on_timer_timeout():
	if difficulty == 0:
		shoot()
	elif difficulty >= 1:
		shoot3()


func shoot():
	var floppy = FLOPPY_DISK.instantiate()
	add_child(floppy)
	floppy.global_position = global_position
	floppy.velocity = player.global_position - global_position
	var rand = int(randf_range(0,3.99))
	floppy.selectFrame(rand)

func shoot3():
	for i in 3:
		var floppy = FLOPPY_DISK.instantiate()
		add_child(floppy)
		floppy.global_position = global_position
		floppy.velocity.x = (player.global_position.x + sin((i-1)*(PI/6))) - global_position.x
		floppy.velocity.y = (player.global_position.y - cos((i-1)*(PI/6))) - global_position.y
		var rand = int(randf_range(0,3.99))
		floppy.selectFrame(rand)
