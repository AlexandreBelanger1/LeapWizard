extends Control
@onready var progress_bar = $ProgressBar

func setMaxHP(amount: int):
	progress_bar.max_value = amount
	progress_bar.value = amount

func loseHP(amount):
	progress_bar.value -= amount

func setHP(amount):
	progress_bar.value = amount

func setPosition(rotate, x, y):
	rotation = rotate
	global_position.x = x
	global_position.y = y
