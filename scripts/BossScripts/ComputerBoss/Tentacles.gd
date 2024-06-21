extends Node2D

@onready var timer = $Timer

const FLOPPY_DISK = preload("res://scenes/floppyDisk.tscn")

var addedDegrees = 0
var difficulty = 0
func pause():
	timer.stop()
	addedDegrees = 0

func play(value: int):
	difficulty = value
	timer.start()

func _on_timer_timeout():
	shoot()


func shoot():
	if difficulty == 0:
		for i in 4:
			var floppy = FLOPPY_DISK.instantiate()
			add_child(floppy)
			floppy.global_position = global_position
			floppy.velocity = Vector2(sin(i*(PI/2) + addedDegrees), -cos(i*(PI/2)+ addedDegrees))
			floppy.selectFrame(i)
		addedDegrees += PI/25
	elif difficulty == 1:
		for i in 4:
			var floppy = FLOPPY_DISK.instantiate()
			add_child(floppy)
			floppy.global_position = global_position
			floppy.velocity = Vector2(sin(i*(PI/2) + addedDegrees), -cos(i*(PI/2)+ addedDegrees))
			floppy.selectFrame(i)
		addedDegrees += PI/15
	elif difficulty == 2:
		for i in 4:
			var floppy = FLOPPY_DISK.instantiate()
			add_child(floppy)
			floppy.global_position = global_position
			floppy.velocity = Vector2(sin(i*(PI/2) + addedDegrees), -cos(i*(PI/2)+ addedDegrees))
			floppy.selectFrame(i)
		for i in 4:
			var floppy = FLOPPY_DISK.instantiate()
			add_child(floppy)
			floppy.global_position = global_position
			floppy.global_position += Vector2(sin(i*(PI/2) + addedDegrees)*240, -cos(i*(PI/2)+ addedDegrees)*240)
			floppy.velocity = Vector2(-sin(i*(PI/2) + addedDegrees), cos(i*(PI/2)+ addedDegrees))
			floppy.selectFrame(i)
		addedDegrees += PI/45
