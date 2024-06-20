extends Node2D
@onready var progress_bar = $ProgressBar
@onready var boss_name = $ProgressBar/BossName

func setMaxHP(value):
	progress_bar.max_value = value

func setHP(value):
	progress_bar.value = value
	if progress_bar.value <= 0:
		queue_free()

func setName(value):
	boss_name.text = value

