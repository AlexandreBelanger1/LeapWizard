extends Control
@onready var progress_bar = $ProgressBar
@onready var blink_timer = $BlinkTimer
@onready var sprite_2d = $Sprite2D

var Mana = 100
var tick = false
func ready():
	progress_bar.value = Mana

func getValue():
	return Mana
	
func setValue(Value):
	Mana = Value
	progress_bar.value = Mana

func setMaxValue(Value):
	progress_bar.max_value = Value

func addValue(Value):
	Mana += Value
	progress_bar.value = Mana

func removeValue(Value):
	Mana -= Value
	progress_bar.value = Mana

func blink(Value: bool):
	if Value:
		blink_timer.start()
	else:
		blink_timer.stop()
		sprite_2d.modulate.a = 1
		progress_bar.modulate.a = 1
	



func _on_blink_timer_timeout():
	if tick:
		sprite_2d.modulate.a = 1
		progress_bar.modulate.a = 1
		tick = false
	else:
		sprite_2d.modulate.a = 0.2
		progress_bar.modulate.a = 0.2
		tick = true
	


func _on_area_2d_body_entered(_body):
	blink(true)


func _on_area_2d_body_exited(_body):
	blink(false)
