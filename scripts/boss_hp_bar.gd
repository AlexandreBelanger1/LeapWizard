extends Node2D
@onready var progress_bar = $ProgressBar
@onready var boss_name = $ProgressBar/BossName


func setHP(value):
	progress_bar.value = value

func setName(value):
	boss_name.text = value

func _process(_delta):
	if progress_bar.value <= 0:
		queue_free()
