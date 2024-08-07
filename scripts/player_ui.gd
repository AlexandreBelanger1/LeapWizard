extends Control

@onready var health_bar = $HealthBar
@onready var animated_sprite_2d = $Character
@onready var egg_counter = $EggCounter
@onready var jumps_counter = $PlayerStatsPanel/JumpStat/StatBackground/JumpsCounter
@onready var damage_counter = $PlayerStatsPanel/DamageStat/StatBackground/DamageCounter
@onready var stats_intro = $StatsIntro
@onready var rune_blue = $RuneBlue
@onready var rune_green = $RuneGreen
@onready var rune_purple = $RunePurple
@onready var rune_red = $RuneRed
@onready var weapon_1 = $WeaponSlot1/Weapon1
@onready var weapon_2 = $WeaponSlot2/Weapon2
@onready var game_manager = $"../.."

var maxHP = 6

func enableStatsIntro():
	stats_intro.visible = true
	
func disableStatsIntro():
	stats_intro.visible = false

func setHealth(HP):
	health_bar.setHealth(HP)
	animated_sprite_2d.frame = maxHP - HP

func setMaxHealth(value):
	health_bar.setMaxHealth(value)
	maxHP = value

func setEggs(Count):
	egg_counter.text = str(Count)

func setJumps(Count):
	jumps_counter.text = str(Count)

func setDamage(Count):
	damage_counter.text = str(Count)

func enableRed():
	rune_red.visible = true

func enableGreen():
	rune_green.visible = true

func enableBlue():
	rune_blue.visible = true

func enablePurple():
	rune_purple.visible = true

func setWeaponSlot1(weapon: String):
	if weapon == "staff":
		weapon_1.frame = 1
	elif weapon == "sword":
		weapon_1.frame = 2
	elif weapon == "beehive":
		weapon_1.frame = 3
	elif weapon == "shield":
		weapon_1.frame = 4
	elif weapon == "bat":
		weapon_1.frame = 5
	else:
		weapon_1.frame = 0

func setWeaponSlot2(weapon: String):
	if weapon == "staff":
		weapon_2.frame = 1
	elif weapon == "sword":
		weapon_2.frame = 2
	elif weapon == "beehive":
		weapon_2.frame = 3
	elif weapon == "shield":
		weapon_2.frame = 4
	elif weapon == "bat":
		weapon_2.frame = 5
	else:
		weapon_2.frame = 0

func _on_weapon_swap_button_pressed():
	var W1 = weapon_1.frame
	weapon_1.frame = weapon_2.frame
	weapon_2.frame = W1
	game_manager.swapWeapons()

func _input(event):
	if event.is_action_pressed("swapWeapons"):
		_on_weapon_swap_button_pressed()
