extends CharacterBody2D

@onready var game_manager = $"../.."
@onready var boss_hp_bar = $BossHPBar
@onready var damaged_sound = $DamagedSound
@onready var body = $AnimatedSprite2D
@onready var player = $"../../Player"
@onready var damaged_timer = $DamagedTimer
@onready var boss_room = $".."



const PLAYER_UPGRADE_CURRENCY = preload("res://scenes/items/player_upgrade_currency.tscn")
const COMPANION_UPGRADE_CURRENCY = preload("res://scenes/items/companion_upgrade_currency.tscn")
const GLITTERING_PORTAL = preload("res://scenes/GlitteringPortal.tscn")


var HP = 10000


func _physics_process(delta):
	boss_hp_bar.global_position.x = player.global_position.x - 100
	boss_hp_bar.global_position.y = player.global_position.y - 112
	

func takeRMBDamage():
	HP -= int(game_manager.get_slot2_total_damage())
	boss_hp_bar.setHP(HP)
	checkDeath()
	applyDamaged()

func takeLMBDamage():
	HP -= int(game_manager.get_slot1_total_damage())
	boss_hp_bar.setHP(HP)
	checkDeath()
	applyDamaged()

func applyDamaged():
	damaged_sound.playing = true
	body.modulate  = Color(255,0,0)
	damaged_timer.start()



func checkDeath():
	if(HP <= 0):
		#End Boss Fight
		boss_room.endFight()

		#Spawn Death Animation


		#Reward the player
		var createItem := func():
			var rng = RandomNumberGenerator.new()
			var random_number = rng.randf_range(1.0, 10.0)
			if random_number < 8:
				generate_player_currency()
			else:
				generate_companion_currency()
		createItem.call_deferred()
		
		#Generate portal to next stage
		var createPortal := func():
			var portal = GLITTERING_PORTAL.instantiate()
			get_parent().get_parent().add_child(portal)
			portal.global_position.y = global_position.y + 16
			portal.global_position.x = global_position.x 
		createPortal.call_deferred()
		
		#Delete enemy
		call_deferred("free")
		#queue_free()
		


func generate_player_currency():
	var item = PLAYER_UPGRADE_CURRENCY.instantiate()
	get_parent().get_parent().add_child(item)
	item.global_position.x = global_position.x - 32
	item.global_position.y = global_position.y +32

func generate_companion_currency():
	var item = COMPANION_UPGRADE_CURRENCY.instantiate()
	get_parent().get_parent().add_child(item)
	item.global_position.x = global_position.x - 32
	item.global_position.y = global_position.y +32

func _on_setup_timeout():
	boss_hp_bar.setName("BOGO")
	boss_hp_bar.setHP(HP)
	boss_hp_bar.setMaxHP(HP)



func _on_damaged_timer_timeout():
	body.modulate  = Color(1,1,1)


