extends Node2D

@onready var timer = $Timer

@onready var player = $"../../Player"

const FLOPPY_DISK = preload("res://scenes/floppyDisk.tscn")
var difficulty = 0
var RNG = RandomNumberGenerator.new()
var positionDifficulty2 = int(randf_range(1,7.99))
var moveDirection = 1
func pause():
	timer.stop()

func play(value: int):
	difficulty = value
	if difficulty == 2:
		timer.wait_time = 0.5
	timer.start()

func _on_timer_timeout():
	shoot()


func shoot():
	if difficulty == 0:
		var floppy = FLOPPY_DISK.instantiate()
		add_child(floppy)
		floppy.global_position.y = global_position.y
		var randPosition = int(randf_range(1,4.99))
		floppy.global_position.x = global_position.x + 16 * randPosition
		floppy.global_position.y = global_position.y
		floppy.velocity = Vector2(0,1)
		var rand = int(randf_range(0,3.99))
		floppy.selectFrame(rand)
	elif difficulty == 1:
		var randPosition = int(randf_range(1,4.99))
		for i in 4:
			if i+1 != randPosition:
				var floppy = FLOPPY_DISK.instantiate()
				add_child(floppy)
				floppy.global_position.y = global_position.y
				floppy.global_position.x = global_position.x + 16 * (i+1)
				floppy.global_position.y = global_position.y
				floppy.velocity = Vector2(0,1)
				var rand = int(randf_range(0,3.99))
				floppy.selectFrame(rand)
	
	elif difficulty == 2:
		for i in 8:
			if i+1 != positionDifficulty2 and i+1 != positionDifficulty2 +1 and i+1 != positionDifficulty2 -1:
				var floppy = FLOPPY_DISK.instantiate()
				add_child(floppy)
				floppy.global_position.y = global_position.y
				floppy.global_position.x = global_position.x + 8 * (i+1)
				floppy.global_position.y = global_position.y
				floppy.velocity = Vector2(0,1)
				var rand = int(randf_range(0,3.99))
				floppy.selectFrame(rand)
		if moveDirection == 1 and positionDifficulty2 == 7:
			moveDirection = -1
		elif moveDirection == -1 and positionDifficulty2 == 2:
			moveDirection = 1
		else:
			positionDifficulty2 += moveDirection
			

