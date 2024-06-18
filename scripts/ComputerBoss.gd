extends StaticBody2D

@onready var game_manager = $"../.."
@onready var boss_hp_bar = $BossHPBar
@onready var damaged_sound = $DamagedSound
@onready var body = $body
@onready var player = $"../../Player"

const PLAYER_UPGRADE_CURRENCY = preload("res://scenes/items/player_upgrade_currency.tscn")
const COMPANION_UPGRADE_CURRENCY = preload("res://scenes/items/companion_upgrade_currency.tscn")
const NEXT_LEVEL_TILE = preload("res://scenes/TileGeneration/NextLevelTile.tscn")


var HP = 4600
var Damaged = false
var DamagedTimer = 0

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
	Damaged = true
	DamagedTimer = 0


func checkDeath():
	if(HP <= 0):
		#Restore Map

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
			var portal = NEXT_LEVEL_TILE.instantiate()
			get_parent().add_child(portal)
			portal.global_position.y = 0
			portal.global_position.x = player.global_position.x + 256
		createPortal.call_deferred()
		
		#Delete enemy
		call_deferred("free")
		#queue_free()
		


func generate_player_currency():
	var item = PLAYER_UPGRADE_CURRENCY.instantiate()
	get_parent().add_child(item)
	item.global_position.x = player.global_position.x - 128
	item.global_position.y = 0

func generate_companion_currency():
	var item = COMPANION_UPGRADE_CURRENCY.instantiate()
	get_parent().add_child(item)
	item.global_position.x = player.global_position.x - 128
	item.global_position.y = 0

func _on_setup_timeout():
	boss_hp_bar.setName("Glorbiquitous-9000")
