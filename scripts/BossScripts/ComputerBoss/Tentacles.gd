extends Node2D

@onready var timer = $Timer

const FLOPPY_DISK = preload("res://scenes/floppyDisk.tscn")

var addedDegrees = 0

func pause():
	timer.stop()
	addedDegrees = 0

func play():
	timer.start()

func _on_timer_timeout():
	shoot()


func shoot():
	for i in 4:
		var floppy = FLOPPY_DISK.instantiate()
		add_child(floppy)
		floppy.global_position = global_position
		floppy.velocity = Vector2(sin(i*(PI/2) + addedDegrees), -cos(i*(PI/2)+ addedDegrees))
		floppy.selectFrame(i)
	addedDegrees += PI/25
