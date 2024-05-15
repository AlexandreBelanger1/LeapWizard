extends Control

@onready var health_bar = $HealthBar
@onready var animated_sprite_2d = $Character
@onready var egg_counter = $PlayerStatsPanel/EggsBackground/EggCounter
@onready var jumps_counter = $PlayerStatsPanel/JumpStat/StatBackground/JumpsCounter
@onready var damage_counter = $PlayerStatsPanel/DamageStat/StatBackground/DamageCounter
@onready var stats_intro = $StatsIntro

func enableStatsIntro():
	stats_intro.visible = true
	
func disableStatsIntro():
	stats_intro.visible = false

func setHealth(HP):
	health_bar.value = HP
	animated_sprite_2d.frame = 4-HP

func setEggs(Count):
	egg_counter.text = str(Count)

func setJumps(Count):
	jumps_counter.text = str(Count)

func setDamage(Count):
	damage_counter.text = str(Count)
