extends Node2D
const spellPath = preload('res://scenes/spell.tscn')
const distance = 10
var a = position
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		cast(event.position)
	elif event is InputEventMouseMotion:
		#a = event.position 
		a = get_global_mouse_position() - global_position
		print("vector x" + str(a.x))
		print("vector y" + str(a.y))
		print("position x" + str(global_position.x))
		print("position y" + str(global_position.y))
		global_position = get_parent().global_position + (a.normalized() * distance)
		
		#var xDist = event.position.x - position.x
		#var yDist = event.position.y - position.y
		#position = Vector2(cos( (xDist/((yDist^2)+(xDist^2))/2)), sin((yDist/((yDist^2)+(xDist^2))/2))) * distance

func cast(target):
	var spell = spellPath.instantiate()
	get_parent().add_child(spell)
	spell.global_position = global_position
