extends CharacterBody2D

@onready var body_animation = $BodyAnimation
@onready var health_bar = $HealthBar
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var game_manager = $"../.."
@onready var damaged_sound = $DamagedSound
@onready var attack_sound = $AttackSound
@onready var damage_scale_timer = $DamageScaleTimer

const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")
const DRAGON_ATTACK = preload("res://scenes/DragonAttack.tscn")

var attacking = false
var FacingPlayer = 0
var target
var speed = 50
var HP = 250
var cooldownTimer: float
var cooldown = 1

func _physics_process(_delta: float) -> void:
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	if (global_position.distance_to(navigation_agent_2d.get_next_path_position())<1):
		speed = 0
	else:
		attacking = false
		speed = 50
	velocity = dir * speed
	if FacingPlayer > 0:
		body_animation.flip_h = false
	else:
		body_animation.flip_h = true
	move_and_slide()

func makePath() -> void:
	FacingPlayer = global_position.x - target.global_position.x
	#if FacingPlayer > 0:
	navigation_agent_2d.target_position.x = global_position.x
	#else:
		#navigation_agent_2d.target_position.x = target.global_position.x-150
	navigation_agent_2d.target_position.y = target.global_position.y

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
	if attacking :
		if (cooldownTimer >= cooldown):
			attack()
			cooldownTimer = 0
		elif cooldownTimer < cooldown:
			cooldownTimer += delta

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
	attacking = false

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
	body_animation.modulate = Color(0,0,255)
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


func _on_navigation_agent_2d_target_reached():
	if(target != null):
		attacking = true



func attack():
	body_animation.animation = "Attack"
	attack_sound.play()
	attack_sound.play()
	var attackprojectile = DRAGON_ATTACK.instantiate()
	attackprojectile.name = "DragonAttack"
	get_parent().add_child(attackprojectile)
	attackprojectile.global_position.x = global_position.x
	attackprojectile.global_position.y = global_position.y 
	if FacingPlayer > 0:
		attackprojectile.velocity = Vector2(-1,0)
		attackprojectile.flipSprite()
	else:
		attackprojectile.velocity = Vector2(1,0)
	


func _on_damage_scale_timer_timeout():
	body_animation.scale.y = 1
	body_animation.offset.y = 0
	body_animation.scale.x = 1
	body_animation.offset.x = 0

func setMaxHP(maxHP: int):
	HP = maxHP
	health_bar.setMaxHP(maxHP)
