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
