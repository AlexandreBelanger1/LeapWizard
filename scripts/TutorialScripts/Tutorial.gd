extends Node

@onready var player_ui = $Camera2D/PlayerUI
@onready var pause_menu = $Camera2D/PauseMenu
@onready var game_manager = $".."
@onready var music = $Audio/Music
@onready var mana_bar = $Camera2D/ManaBar
@onready var player = $Player
@onready var rune_sound = $Audio/RuneSound
const BOSS_SPAWNER = preload("res://scenes/boss_spawner.tscn")
#const GAME_SCENE_2 = preload("res://scenes/GameScene2.tscn")


var playerUpgrades = []
var companionUpgrades = []
var playerItems = []

func _ready():
	game_manager.add_point()
	player_ui.setHealth(game_manager.get_player_HP())
	player_ui.setMaxHealth(game_manager.get_player_maxHP())
	player_ui.setEggs(game_manager.get_player_score())
	player_ui.setJumps(game_manager.get_player_jumps())
	player_ui.setDamage(game_manager.get_player_damage())
	mana_bar.setValue(game_manager.get_player_mana())
	#Initialize player to reload previous spell stats
	set_slot1_CD(game_manager.get_slot1_CD())
	set_slot1_cost(game_manager.get_slot1_cost())
	set_slot1_name(game_manager.get_slot1_name())
	set_slot2_CD(game_manager.get_slot2_CD())
	set_slot2_cost(game_manager.get_slot2_cost())
	set_slot2_name(game_manager.get_slot2_name())
	#Initialize unlocked player and companion upgrades
	playerUpgrades.append(get_player_loadout_array(1))
	playerUpgrades.append(get_player_loadout_array(2))
	companionUpgrades.append(get_companion_loadout_array(1))
	companionUpgrades.append(get_companion_loadout_array(2))
	#Retrieve player items
	getItems(game_manager.getItems())



const SEAGULL = preload("res://scenes/seagull.tscn")
const TORTOISE = preload("res://scenes/tortoise.tscn")
#Player Item control
func getItems(itemList):
	if itemList != null:
		for i in itemList.size():
			playerItems.append(itemList[i])
			instantiateItem(itemList[i])

func addItem(item: String):
	playerItems.append(item)

func instantiateItem(item):
	if item == "Seagull":
		seagullPickup()
	elif item == "Tortoise":
		tortoisePickup()

func seagullPickup():
	var createItem := func():
		var item = SEAGULL.instantiate()
		add_child(item)
		item.global_position = player.global_position
	createItem.call_deferred()

func tortoisePickup():
	var createItem := func():
		var item = TORTOISE.instantiate()
		player.add_child(item)
		item.global_position = player.global_position
	createItem.call_deferred()





#Music and SFX
func pauseMusic():
	music.stream_paused = true

func unpauseMusic():
	music.stream_paused = false

func playRuneSound():
	rune_sound.playing = true

#Create boss spawner
func activateBoss():
	var BossSpawner = BOSS_SPAWNER.instantiate()
	add_child(BossSpawner)
	BossSpawner.global_position.x = 4440
	BossSpawner.global_position.y = 1

#Handle Rune Activation
var runeIndex = [0,0,0,0]
func add_rune(index):
	runeIndex[index] = 1
	if index == 0:
		player_ui.enableRed()
	elif index == 1:
		player_ui.enableBlue()
	elif index == 2:
		player_ui.enableGreen()
	elif index == 3:
		player_ui.enablePurple()
	playRuneSound()
	if(runeIndex[0] and runeIndex[1] and runeIndex[2] and runeIndex[3]):
		activateBoss()

#Save game variables
func save_game():
	game_manager.save_game()

#SaveSetters
func set_player_upgrade_currency(value:int):
	game_manager.set_player_upgrade_currency(value)

func set_companion_upgrade_currency(value:int):
	game_manager.set_companion_upgrade_currency(value)

func set_player_loadout_array(index:int, value:bool):
	game_manager.set_player_loadout_array(index,value)

func set_companion_loadout_array(index:int, value:bool):
	game_manager.set_companion_loadout_array(index,value)

#SaveGetters
func get_player_upgrade_currency():
	return game_manager.get_player_upgrade_currency()

func get_companion_upgrade_currency():
	return game_manager.get_companion_upgrade_currency()

func get_player_loadout_array(index:int):
	return game_manager.get_player_loadout_array(index)

func get_companion_loadout_array(index:int):
	return game_manager.get_companion_loadout_array(index)

#Getters for player and companion upgrades in-game
func get_player_upgrade(index:int):
	return playerUpgrades[index]

func get_companion_upgrade(index:int):
	return companionUpgrades[index]



#Player Mana system variables
func get_player_max_mana():
	return  game_manager.get_player_max_mana()

func set_player_max_mana(value):
	mana_bar.setMaxValue(value)

func get_player_mana_CD():
	return game_manager.get_player_mana_CD()

func get_player_mana_rate():
	return game_manager.get_player_mana_rate()

func set_player_mana_CD(value):
	game_manager.set_player_mana_CD(value)

func set_player_mana_rate(value):
	game_manager.set_player_mana_rate(value)

func get_player_mana():
	return game_manager.get_player_mana()

func set_player_mana(value):
	game_manager.set_player_mana(value)
	mana_bar.setValue(value)

func remove_player_mana(value):
	game_manager.remove_player_mana(value)
	mana_bar.removeValue(value)

func add_player_mana(value):
	game_manager.add_player_mana(value)
	mana_bar.addValue(value)

#Spell system variables

#Calculated spell values with base and multiplier
func get_slot1_total_damage():
	return game_manager.get_slot1_total_damage()

func get_slot1_total_cost():
	return game_manager.get_slot1_total_cost()

func get_slot1_total_CD():
	return game_manager.get_slot1_total_CD()

func get_slot2_total_damage():
	return game_manager.get_slot2_total_damage()

func get_slot2_total_cost():
	return game_manager.get_slot2_total_cost()

func get_slot2_total_CD():
	return game_manager.get_slot2_total_CD()


#SpellSlot1 Variables
func get_slot1_name():
	return game_manager.get_slot1_name()

func set_slot1_name(value):
	game_manager.set_slot1_name(value)
	player.set_slot1_name(value)
	set_slot1_cost(get_slot1_cost())
	set_slot1_CD(get_slot1_CD())

func get_slot1_damage():
	return game_manager.get_slot1_damage()

func set_slot1_damage(value):
	game_manager.set_slot1_damage(value)

func get_slot1_cost():
	return game_manager.get_slot1_cost()

func set_slot1_cost(value):
	game_manager.set_slot1_cost(value)
	player.set_slot1_cost(get_slot1_total_cost())

func get_slot1_CD():
	return game_manager.get_slot1_CD()

func set_slot1_CD(value):
	game_manager.set_slot1_CD(value)
	player.set_slot1_CD(get_slot1_total_CD())


#SpellSlot2 Variables
func get_slot2_name():
	return game_manager.get_slot2_name()

func set_slot2_name(value):
	game_manager.set_slot2_name(value)
	player.set_slot2_name(value)
	set_slot2_cost(get_slot2_cost())
	set_slot2_CD(get_slot2_CD())

func get_slot2_damage():
	return game_manager.get_slot2_damage()

func set_slot2_damage(value):
	game_manager.set_slot2_damage(value)

func get_slot2_cost():
	return game_manager.get_slot2_cost()

func set_slot2_cost(value):
	game_manager.set_slot2_cost(value)
	player.set_slot2_cost(get_slot2_total_cost())

func get_slot2_CD():
	return game_manager.get_slot2_CD()

func set_slot2_CD(value):
	game_manager.set_slot2_CD(value)
	player.set_slot2_CD(get_slot2_total_CD())






func add_player_damage(value):
	game_manager.add_player_damage(value)
	player_ui.setDamage(game_manager.get_player_damage())

func remove_points(value):
	game_manager.remove_points(value)
	player_ui.setEggs(game_manager.get_player_score())

func add_point():
	game_manager.add_point()
	player_ui.setEggs(game_manager.get_player_score())

#PAUSE MENU CONTROL
func _process(_delta):
	if Input.is_action_just_pressed("Pause_game"):
		pauseMenu()
	

func pauseMenu():
		pause_menu.show()
		get_tree().paused = true
		

#Handles player death
func changeHealth(Value):
	game_manager.changeHealth(Value)
	player_ui.setHealth(game_manager.get_player_HP())
	if(game_manager.get_player_HP() < 1):
		#Animate Death
		playerDeath()
		#wait a bit
		#get_tree().reload_current_scene()

func addJumps(Value):
	game_manager.addJumps(Value)
	player_ui.setJumps(get_player_jumps())
	
func get_player_damage():
	return game_manager.get_player_damage()

func get_player_jumps():
	return game_manager.get_player_jumps()

func get_player_speed():
	return game_manager.get_player_speed()

func get_player_score():
	return game_manager.get_player_score()

func get_player_HP():
	return game_manager.get_player_HP()

func get_player_maxHP():
	return game_manager.get_player_maxHP()

func set_player_maxHP(value):
	game_manager.set_player_maxHP(value)
	player_ui.setMaxHealth(value)

func get_world_number():
	return game_manager.get_world_number()


func playerDeath():
	player.deathProcess()

func NextWorld():
	game_manager.setItems(playerItems)
	game_manager.NextWorld()
	queue_free()
	
@onready var open_chest_text = $Labels/OpenChestText

func openChest():
	open_chest_text.visible = true
