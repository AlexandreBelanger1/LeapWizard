extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager =  $".."
@onready var shoot = $Shoot
@onready var player_hurt_sound = $PlayerHurtSound
@onready var death_timer = $DeathTimer
@onready var player_death_sound = $PlayerDeathSound
@onready var hit_box = $HitBox

var jumpCount = 0
var SPEED = 90.0
const JUMP_VELOCITY = -325.0
var sprintToggle = false
var playerDead = false

var playerDamaged = false
var playerDamagedTimer = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Detect unhandled mouse events
var mousePressed = false
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
	if mouse1Pressed or mouse2Pressed:
		mousePressed = true
	else:
		mousePressed = false
#Handles Player Movement

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	if !playerDead:
		if playerDamaged:
			playerDamagedTimer += delta
			if playerDamagedTimer > 0.5:
				playerDamaged = false
				animated_sprite_2d.modulate = Color(1, 1, 1)
				playerDamagedTimer = 0
		# Add the gravity.
		#if not is_on_floor():
		

		if velocity.y > 0:
			velocity += Vector2.UP * -1 * 2
		elif velocity.y < 0 and Input.is_action_just_released("ui_accept"):
			velocity += Vector2.UP * -9.81 * 6
		# Handle jump.
		if Input.is_action_pressed("ui_accept") and jumpCount < 1:
			velocity.y = JUMP_VELOCITY
			jumpCount += 1

		elif(Input.is_action_just_pressed("ui_accept") and (jumpCount < game_manager.get_player_jumps())):
			velocity.y = JUMP_VELOCITY
			jumpCount += 1

		
		if is_on_floor() and velocity.y >= 0:
			jumpCount = 0

		#PassThrough oneway tiles
		if Input.is_action_pressed("OffLedge"):
			set_collision_mask_value(13,false)
		if Input.is_action_just_released("OffLedge"):
			set_collision_mask_value(13,true) 
		
		#sprint
		if Input.is_action_just_pressed("sprintToggle"):
			if sprintToggle:
				SPEED = 90
				sprintToggle = false
			else:
				SPEED = 150
				sprintToggle = true
		if !sprintToggle:
			if Input.is_action_pressed("sprint"):
				SPEED = 150
			if Input.is_action_just_released("sprint"):
				SPEED = 90

		#Player Animation
		var direction = Input.get_axis("player_move_left", "player_move_right")
		if mousePressed:
			animated_sprite_2d.animation = "Attack"
			if(get_viewport().get_mouse_position().x < 625):
				animated_sprite_2d.flip_h = true
			else:
				animated_sprite_2d.flip_h = false
			if direction != 0:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
				#Flip sprite if aiming behind player sprite
			if(get_viewport().get_mouse_position().x < 625):
				animated_sprite_2d.flip_h = true
				
		else:
			
			if direction != 0:
				velocity.x = direction * SPEED
				animated_sprite_2d.animation = "Walk"
			
				if direction < 0:
					animated_sprite_2d.flip_h = true
				else:
					animated_sprite_2d.flip_h = false
			
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				animated_sprite_2d.flip_h = false
				animated_sprite_2d.animation = "Idle"
	move_and_slide()


func takeDamage():
	if !playerDead:
		animated_sprite_2d.modulate = Color(255,0,0)
		player_hurt_sound.playing = true
		playerDamaged = true
		game_manager.changeHealth(-1)

func _input(event):
	if event.is_action_pressed("DeveloperCheat"):
		for x in 100:
			game_manager.add_point()

#Mana system handling
var mana = 0
var manaRegenerationRate = 1
var manaRegenerationCooldown = 1
var manaTimer = 0
var cooldown1 = 1
var cost1 = 1
var cooldown2 = 1
var cost2 = 0

func _process(delta):
	mana = game_manager.get_player_mana()
	manaRegenerationCooldown = game_manager.get_player_mana_CD()
	manaRegenerationRate = game_manager.get_player_mana_rate()
	manaTimer += delta
	
	#if Mana has room to regenerate, then add regen rate
	if manaTimer >= manaRegenerationCooldown:
		if mana + manaRegenerationRate <= game_manager.get_player_max_mana():
			game_manager.add_player_mana(manaRegenerationRate)
			manaTimer = 0
			#otherwise, set to max value
		else:
			game_manager.set_player_mana(game_manager.get_player_max_mana())
			manaTimer = 0
	

func set_slot1_cost(value):
	cost1 = value
	shoot.set_slot1_cost(value)

func set_slot1_CD(value):
	cooldown1 = value
	shoot.set_slot1_CD(value)

func set_slot1_name(value):
	shoot.set_slot1_name(value)

func set_slot2_cost(value):
	cost2 = value
	shoot.set_slot2_cost(value)

func set_slot2_CD(value):
	cooldown2 = value
	shoot.set_slot2_CD(value)

func set_slot2_name(value):
	shoot.set_slot2_name(value)



func deathProcess():
	animated_sprite_2d.modulate = Color(1, 1, 1)
	if is_instance_valid(hit_box):
		hit_box.call_deferred("free")
	if is_instance_valid(shoot):
		shoot.call_deferred("free")
	playerDead = true
	player_death_sound.playing = true
	animated_sprite_2d.animation = "Death"
	death_timer.start()




func _on_death_timer_timeout():
	get_tree().reload_current_scene()


func _on_hit_box_body_entered(_body):
	takeDamage()
