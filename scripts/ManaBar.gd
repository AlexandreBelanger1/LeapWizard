extends Control
@onready var progress_bar = $ProgressBar

var Mana = 100

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
