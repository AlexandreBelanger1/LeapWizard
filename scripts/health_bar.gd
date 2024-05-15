extends Control
@onready var progress_bar = $ProgressBar

func loseHP(amount):
	progress_bar.value -= amount
func setHP(amount):
	progress_bar.value = amount
