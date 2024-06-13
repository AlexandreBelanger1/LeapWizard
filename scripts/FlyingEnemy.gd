extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var player = $"../../Player"
@onready var attack_sound = $AttackSound
@onready var eye = $EyeShoot/Eye
@onready var health_bar = $HealthBar
@onready var body_animation = $BodyAnimation
@onready var damaged_sound = $DamagedSound
@onready var navigation_agent_2d = $NavigationAgent2D

const MANA_PICKUP = preload("res://scenes/items/mana_pickup.tscn")
const ENEMY_DEATH_PARTICLES = preload("res://scenes/enemy_death_particles.tscn")

var HP = 250
const distance = 1
var pointToPlayer = position
const attackPath = preload('res://scenes/boss_attack.tscn')
var cooldownTimer: float
var cooldown = 1
var prediction = position
var target = null
var speed = 80
var attacking = false

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
	
	pointToPlayer = player.global_position - eye.global_position
	eye.global_position = global_position + (pointToPlayer.normalized() * distance)
	


func attack():
	attack_sound.play()
	var attackprojectile = attackPath.instantiate()
	attackprojectile.name = "FlyingEnemyAttack"
	get_parent().add_child(attackprojectile)
	attackprojectile.global_position.x = global_position.x
	attackprojectile.global_position.y = global_position.y +5
	
	#predict where player is going
	prediction = player.global_position - attackprojectile.global_position
	
	#attack.velocity = prediction  - attack.global_position
	attackprojectile.velocity = prediction 

func setHP(value):
	HP = value
	health_bar.setHP(HP)

func _physics_process(delta: float) -> void:
	if attacking:
		if (cooldownTimer >= cooldown):
			attack()
			cooldownTimer = 0
		elif cooldownTimer < cooldown:
			cooldownTimer += delta
	
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	if (global_position.distance_to(navigation_agent_2d.get_next_path_position())<1):
		speed = 0
	else:
		speed = 50
	velocity = dir * speed
	move_and_slide()

func makePath() -> void:
	navigation_agent_2d.target_position.x = target.global_position.x
	navigation_agent_2d.target_position.y = target.global_position.y - 20


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
		if game_manager.get_player_upgrade(1):
			var RNG = RandomNumberGenerator.new()
			var manaDropOdds = RNG.randf_range(0.0,10.0)
			if manaDropOdds > 8:
				var createItem := func():
					var mana = MANA_PICKUP.instantiate()
					get_parent().get_parent().add_child(mana)
					mana.global_position = global_position
				createItem.call_deferred()
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


func _on_aggro_range_body_entered(body):
	target = body
	attacking = true


func _on_aggro_range_body_exited(_body):
	target = null
	attacking = false


func _on_timer_timeout():
	if target != null:
		makePath()
