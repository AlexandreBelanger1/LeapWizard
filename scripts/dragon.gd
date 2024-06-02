extends CharacterBody2D

@onready var body_animation = $BodyAnimation
@onready var health_bar = $HealthBar
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var game_manager = $"../../.."
@onready var damaged_sound = $DamagedSound
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")


var target
const speed = 50
var HP = 250

func _physics_process(_delta: float) -> void:
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	velocity = dir * speed
	if dir.x < 0:
		body_animation.flip_h = false
	else:
		body_animation.flip_h = true
	move_and_slide()

func makePath() -> void:
	navigation_agent_2d.target_position = target.global_position

var Damaged = false
var DamagedTimer = 0
func _process(delta):
	
	#Colour change for taking damage
	if Damaged:
		DamagedTimer += delta
		if DamagedTimer > 0.25:
			Damaged = false
			body_animation.modulate = Color(1, 1, 1)
			DamagedTimer = 0
	

func setHP(value):
	HP = value
	health_bar.setHP(HP)

func _on_timer_timeout():
	if target != null:
		makePath()

func _on_aggro_range_body_entered(body):
	target = body

func _on_aggro_range_body_exited(_body):
	target = null

func checkDeath():
	if(HP <= 0):
		#Spawn Death Animation
		var deathSmoke = ENEMY_DEATH_PARTICLES.instantiate()
		deathSmoke.global_position = global_position
		get_parent().add_child(deathSmoke)
		deathSmoke.global_position = global_position
		#Reward the player
		game_manager.add_point()
		#Delete enemy
		call_deferred("free")
		#queue_free()

func applyDamaged():
	damaged_sound.playing = true
	body_animation.modulate = Color(255,0,0)
	Damaged = true
	DamagedTimer = 0

func takeLMBDamage():
	HP -= int(game_manager.get_slot1_total_damage())
	health_bar.loseHP(game_manager.get_slot1_total_damage())
	checkDeath()
	applyDamaged()

func takeRMBDamage():
	HP -= int(game_manager.get_slot2_total_damage())
	health_bar.loseHP(game_manager.get_slot2_total_damage())
	checkDeath()
	applyDamaged()
