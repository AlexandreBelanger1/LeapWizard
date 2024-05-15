extends Node2D
@onready var cast_sound = $"../CastSound"


const spellPath = preload('res://scenes/spell.tscn')
const distance = 5
var pointToMouse = position
var cooldownTimer: float
var cooldown = 0.1
var mousePressed = false
func _unhandled_input(event):
	if event.is_action_pressed("Cast"):
		mousePressed = true
	elif event.is_action_released("Cast"):
		mousePressed = false

#Handle cast trigger and cooldown, and moves shoot hitbox
func _process(delta):
	pointToMouse = get_global_mouse_position() - global_position
	global_position = get_parent().global_position + (pointToMouse.normalized() * distance)
	if (cooldownTimer >= cooldown) and mousePressed:
		cooldownTimer = 0
		cast()
	elif cooldownTimer < cooldown:
		cooldownTimer += delta

#Handle creation of spell object with direction vector to follow
func cast():
	cast_sound.play()
	var spell = spellPath.instantiate()
	spell.name = "spell"
	get_parent().get_parent().add_child(spell)
	spell.global_position = global_position
	
	spell.velocity = get_global_mouse_position() - spell.global_position
	if(spell.velocity.x >0):
		spell.rotate(atan( spell.velocity.y/spell.velocity.x)) 
	else:
		spell.rotate(PI+ atan( spell.velocity.y/spell.velocity.x)) 
	
	
