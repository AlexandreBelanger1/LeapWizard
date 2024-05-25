extends Node2D
@onready var cast_sound = $"../CastSound"

const swordPath = preload("res://scenes/Sword.tscn")
const spellPath = preload('res://scenes/spell.tscn')
const distance = 5
var pointToMouse = position
var cooldown1Timer: float
var cooldown2Timer: float
var cooldown1 = 0.5
var cooldown2 = 0.5
var cost1 = 0
var cost2 = 0
var slot1Name = "staff"
var slot2Name = "staff"
var mouse1Pressed = false
var mouse2Pressed = false
func _unhandled_input(event):
	if event.is_action_pressed("Cast1"):
		mouse1Pressed = true
	elif event.is_action_released("Cast1"):
		mouse1Pressed = false
	if event.is_action_pressed("Cast2"):
		mouse2Pressed = true
	elif event.is_action_released("Cast2"):
		mouse2Pressed = false

#Handle cast trigger and cooldown, and moves shoot hitbox
func _process(delta):
	#Track mouse movement to shooting hitbox
	pointToMouse = get_global_mouse_position() - global_position
	global_position = get_parent().global_position + (pointToMouse.normalized() * distance)
	
	#Casting cooldowns tracked with time
	cooldown1Timer += delta
	cooldown2Timer += delta
	
	#LMB Cast
	if (cooldown1Timer >= cooldown1) and mouse1Pressed:
		if cost1 <= get_parent().mana:
			get_parent().game_manager.remove_player_mana(cost1)
			cooldown1Timer = 0
			cast(slot1Name)
	#RMB Cast
	if (cooldown2Timer >= cooldown2) and mouse2Pressed:
		if cost2 <= get_parent().mana:
			get_parent().game_manager.remove_player_mana(cost2)
			cooldown2Timer = 0
			cast(slot2Name)
	
		

#Handle creation of spell object with direction vector to follow
func cast(spellName):
	if(spellName == "staff"):
		staffCast()
	elif(spellName == "sword"):
		swordCast()
	else:
		pass

func set_slot1_cost(value):
	cost1 = value

func set_slot1_CD(value):
	cooldown1 = value

func set_slot1_name(value):
	slot1Name = value

func set_slot2_cost(value):
	cost2 = value

func set_slot2_CD(value):
	cooldown2 = value

func set_slot2_name(value):
	slot2Name = value

func staffCast():
	cast_sound.play()
	var spell = spellPath.instantiate()
	get_parent().get_parent().add_child(spell)
	spell.global_position = global_position
	
	spell.velocity = get_global_mouse_position() - spell.global_position
	if(spell.velocity.x >0):
		spell.rotate(atan( spell.velocity.y/spell.velocity.x)) 
	else:
		spell.rotate(PI+ atan( spell.velocity.y/spell.velocity.x)) 

func swordCast():
	var sword = swordPath.instantiate()
	get_parent().add_child(sword)
	sword.global_position = global_position
	if(get_viewport().get_mouse_position().x < 625):
		sword.reverseSpin()
