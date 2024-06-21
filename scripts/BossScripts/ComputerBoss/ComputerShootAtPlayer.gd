extends Node2D

@onready var timer = $Timer

@onready var player = $"../../Player"

const FLOPPY_DISK = preload("res://scenes/floppyDisk.tscn")

var RNG = RandomNumberGenerator.new()
func pause():
	timer.stop()

func play():
	timer.start()

func _on_timer_timeout():
	shoot()


func shoot():
	var floppy = FLOPPY_DISK.instantiate()
	add_child(floppy)
	floppy.global_position = global_position
	floppy.velocity = player.global_position - global_position
	var rand = int(randf_range(0,3.99))
	floppy.selectFrame(rand)
