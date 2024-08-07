extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var player = $"../../Player"
@onready var health_bar = $HealthBar
@onready var body_animation = $BodyAnimation
@onready var damaged_sound = $DamagedSound
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var damage_scale_timer = $DamageScaleTimer

const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")

var HP = 250
var target = null
var speed = 80


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

func _physics_process(delta: float) -> void:

	
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	if (global_position.distance_to(navigation_agent_2d.get_next_path_position())<1):
		speed = 0
	else:
		speed = 50
	velocity = dir * speed
	move_and_slide()

func makePath() -> void:
	navigation_agent_2d.target_position.x = target.global_position.x
	navigation_agent_2d.target_position.y = target.global_position.y 


var dead = false
func checkDeath():
	if HP <= 0 and !dead:
		dead = true
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
	body_animation.scale.y = 1.1
	body_animation.offset.y = -0.5
	body_animation.scale.x = 1.1
	body_animation.offset.x = -0.5
	damage_scale_timer.start()
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


func _on_aggro_range_body_entered(body):
	target = body



func _on_aggro_range_body_exited(_body):
	target = null



func _on_timer_timeout():
	if target != null:
		makePath()


func _on_damage_scale_timer_timeout():
	body_animation.scale.y = 1
	body_animation.offset.y = 0
	body_animation.scale.x = 1
	body_animation.offset.x = 0

func setMaxHP(maxHP: int):
	HP = maxHP
	health_bar.setMaxHP(maxHP)


