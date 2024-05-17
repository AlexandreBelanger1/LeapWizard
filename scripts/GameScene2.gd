extends Node
#@onready var game_manager = %GameManager
@onready var player_ui = $Camera2D/PlayerUI
@onready var pause_menu = $Camera2D/PauseMenu
@onready var game_manager = $".."
@onready var music = $Audio/Music
@onready var boss_spawner = $BossSpawner
@onready var mana_bar = $Camera2D/ManaBar
@onready var player = $Player
@onready var rune_sound = $Audio/RuneSound

var runeIndex = [0,0,0,0]

func pauseMusic():
	music.stream_paused = true

func unpauseMusic():
	music.stream_paused = false

func playRuneSound():
	rune_sound.playing = true

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
	GenerateLevel(8,20)

func activateBoss():
	boss_spawner.bossEnabled = true

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

#SpellSlot1 Variables
func get_slot1_name():
	return game_manager.get_slot1_name()

func set_slot1_name(value):
	game_manager.set_slot1_name(value)
	player.set_slot1_name(value)

func get_slot1_damage():
	return game_manager.get_slot1_damage()

func set_slot1_damage(value):
	game_manager.set_slot1_damage(value)

func get_slot1_cost():
	return game_manager.get_slot1_cost()

func set_slot1_cost(value):
	game_manager.set_slot1_cost(value)
	player.set_slot1_cost(value)

func get_slot1_CD():
	return game_manager.get_slot1_CD()

func set_slot1_CD(value):
	game_manager.set_slot1_CD(value)
	player.set_slot1_CD(value)


#SpellSlot2 Variables
func get_slot2_name():
	return game_manager.get_slot2_name()

func set_slot2_name(value):
	game_manager.set_slot2_name(value)
	player.set_slot2_name(value)

func get_slot2_damage():
	return game_manager.get_slot2_damage()

func set_slot2_damage(value):
	game_manager.set_slot2_damage(value)

func get_slot2_cost():
	return game_manager.get_slot2_cost()

func set_slot2_cost(value):
	game_manager.set_slot2_cost(value)
	player.set_slot2_cost(value)

func get_slot2_CD():
	return game_manager.get_slot2_CD()

func set_slot2_CD(value):
	game_manager.set_slot2_CD(value)
	player.set_slot2_CD(value)






func add_player_damage(value):
	game_manager.add_player_damage(value)
	player_ui.setDamage(game_manager.get_player_damage())

func remove_points(value):
	game_manager.remove_points(value)
	player_ui.setEggs(game_manager.get_player_score())

func add_point():
	game_manager.add_point()
	player_ui.setEggs(game_manager.get_player_score())
	
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
		#wait a bit
		get_tree().reload_current_scene()

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



# WORLD ARRAY LEGEND:
# 0 = open space
# 1 = reserved space
# 2 = navigable space
# 3 = feature size 1
# 4 = feature size 2
# 5 = feature size 3
# 10 = rune pillar

func GenerateLevel(ySize,xSize):
	#World array initialized to all zeros.
	var worldArray = []
	for i in xSize:
		worldArray.append([])
		for j in ySize:
			worldArray[i].append(0)
			
	
	#Determine 4 unique locations to place runes
	#Start by generating rune array of map size and fill with random values
	var rng = RandomNumberGenerator.new()
	var runeArray = []
	for i in xSize:
		runeArray.append([])
		for j in ySize:
			var random_number = rng.randf_range(1.0, 10.0)
			runeArray[i].append(random_number)
	#Now, find the 4 highest values from the rune array and record the i,j positions of the values
	var maxI = [0,0,0,0]
	var maxJ = [0,0,0,0]
	var highest4 = [0,0,0,0]
	for i in xSize:
		for j in ySize:
			#If largest found, bump down the top4 and insert new highest at top, record indices
			if runeArray[i][j] > highest4[3]:
				highest4[0] = highest4[1]
				highest4[1] = highest4[2]
				highest4[2] = highest4[3]
				highest4[3] = runeArray[i][j]
				#Record i positions
				maxI[0] = maxI[1]
				maxI[1] = maxI[2]
				maxI[2] = maxI[3]
				maxI[3] = i
				#Record j positions
				maxJ[0] = maxJ[1]
				maxJ[1] = maxJ[2]
				maxJ[2] = maxJ[3]
				maxJ[3] = j
			elif runeArray[i][j] > highest4[2]:
				highest4[0] = highest4[1]
				highest4[1] = highest4[2]
				highest4[2] = runeArray[i][j]
				#Record i positions
				maxI[0] = maxI[1]
				maxI[1] = maxI[2]
				maxI[2] = i
				#Record j positions
				maxJ[0] = maxJ[1]
				maxJ[1] = maxJ[2]
				maxJ[2] = j
			elif runeArray[i][j] > highest4[1]:
				highest4[0] = highest4[1]
				highest4[1] = runeArray[i][j]
				#Record i positions
				maxI[0] = maxI[1]
				maxI[1] = i
				#Record j positions
				maxJ[0] = maxJ[1]
				maxJ[1] = j
			elif runeArray[i][j] > highest4[0]:
				highest4[0] = runeArray[i][j] 
				#Record i positions
				maxI[0] = i
				#Record j positions
				maxJ[0] = j
	
	
	
	for x in 4:
		#Spawn in the 4 Rune Terrains at i,j positions
		var tilePath = GFS
		if x == 0:
			tilePath = RED_RUNE_TERRAIN
		elif x == 1:
			tilePath = BLUE_RUNE_TERRAIN
		elif x == 2:
			tilePath = GREEN_RUNE_TERRAIN
		else:
			tilePath = PURPLE_RUNE_TERRAIN
		var worldTile = tilePath.instantiate()
		worldTile.global_position.x = maxI[x-1]*128
		worldTile.global_position.y = -maxJ[x-1]*128
		add_child(worldTile)
		
		#Record positions into worldArray as value 10
		worldArray[maxI[x-1]][maxJ[x-1]] = 10
		
		#Create a randomized route of navigable tiles up to the rune
		var TilePositionI = maxI[x-1]
		var TilePositionJ = maxJ[x-1]
		while TilePositionJ != 0:
			var random_number = rng.randf_range(1.0, 10.0)
			
			#Left tile placement logic
			if random_number <= 2.5 and TilePositionI >0:
				#Select tile to the left
				TilePositionI -= 1
				#tempPosition will set the position of the new tile on the right side if no spots available left
				var tempPosition = 2
				#If new tile is not a rune, it becomes navigable
				if worldArray[TilePositionI][TilePositionJ] != 10:
					worldArray[TilePositionI][TilePositionJ] = 2
				#Handle case where multiple runes are next to one another
				elif(TilePositionI > 0): 
					TilePositionI -= 1
					tempPosition += 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				elif(TilePositionI > 0): 
					TilePositionI -= 1
					tempPosition += 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				elif(TilePositionI > 0): 
					TilePositionI -= 1
					tempPosition += 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				#No spots available on the left, check spots on the right side
				else:
					TilePositionI += tempPosition
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
					else:
						TilePositionI += tempPosition
						if worldArray[TilePositionI][TilePositionJ] != 10:
							worldArray[TilePositionI][TilePositionJ] = 2
						else:
							TilePositionI += tempPosition
							if worldArray[TilePositionI][TilePositionJ] != 10:
								worldArray[TilePositionI][TilePositionJ] = 2
			
			
			#Right tile placement logic
			elif random_number > 2.5 and random_number < 5.0 and TilePositionI < xSize-1:
				#Select tile to the right
				TilePositionI += 1
				#tempPosition will set the position of the new tile on the right side if no spots available left
				var tempPosition = 2
				#If new tile is not a rune, it becomes navigable
				if worldArray[TilePositionI][TilePositionJ] != 10:
					worldArray[TilePositionI][TilePositionJ] = 2
				#Handle case where multiple runes are next to one another
				elif(TilePositionI < xSize-1): 
					TilePositionI += 1
					tempPosition -= 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				elif(TilePositionI < xSize): 
					TilePositionI += 1
					tempPosition -= 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				elif(TilePositionI < xSize): 
					TilePositionI += 1
					tempPosition -= 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
				#No spots available on the right, check spots on the left side
				else:
					TilePositionI -= 1
					if worldArray[TilePositionI][TilePositionJ] != 10:
						worldArray[TilePositionI][TilePositionJ] = 2
					else:
						TilePositionI -= 1
						if worldArray[TilePositionI][TilePositionJ] != 10:
							worldArray[TilePositionI][TilePositionJ] = 2
						else:
							TilePositionI -= 1
							if worldArray[TilePositionI][TilePositionJ] != 10:
								worldArray[TilePositionI][TilePositionJ] = 2
			
			#Downward logic checks to see if 1 lower is rune, if not, navigable
			elif random_number >=5 and TilePositionJ > 0:
				TilePositionJ -= 1
				if worldArray[TilePositionI][TilePositionJ] != 10:
					worldArray[TilePositionI][TilePositionJ] = 2
				else:
					TilePositionJ +=1
	
	#Generate features off of the navigable pathways
	for i in xSize:
		for j in ySize:
			
			#if not at zero border, check left spaces
			if worldArray[i][j] == 2 and i>0:
				#x increments left spaces moved
				var x = 1
				#detect is pathway is blocked
				var pathBlocked = false
				#iterate until zero border
				while i-x >= 0 and !pathBlocked:
					if worldArray[i-x][j] == 0:
						x += 1
					else:
						pathBlocked = true
				x -= 1
				if (x > 0):
					var random_number = rng.randf_range(1.0, 5.0 + x)
					if random_number > 2.0 and random_number <= 6.0:
						worldArray[i-1][j] = 3 #1 size
					elif random_number > 6.0 and random_number <= 7.0:
						worldArray[i-1][j] = 1 #reserve spot for 2 size
						worldArray[i-2][j] = 4 #2 size
					elif random_number > 7.0:
						worldArray[i-1][j] = 1 #reserve spot for 3 size
						worldArray[i-2][j] = 1 #reserve spot for 3 size
						worldArray[i-3][j] = 5 #3 size
					#else:
						#for u in x:
							#worldArray[i-u][j] = 1 #Block further generation attempts
			
			#if not at max border, check right spaces
			elif worldArray[i][j] == 2 and i<xSize:
				#x increments right spaces moved
				var x = 1
				#detect is pathway is blocked
				var pathBlocked = false
				#iterate until max border
				while i+x < xSize and !pathBlocked:
					if worldArray[i+x][j] == 0:
						x += 1
					else:
						pathBlocked = true
				x -= 1
				if (x > 0):
					var random_number = rng.randf_range(1.0, 5.0 + (x-1))
					if random_number > 5.0 and random_number <= 6.0:
						worldArray[i+1][j] = 3 #1 size
					elif random_number > 6.0 and random_number <= 7.0:
						worldArray[i+1][j] = 4 #2 size
						worldArray[i+2][j] = 1 #reserve spot for 2 size
					elif random_number > 7.0:
						worldArray[i+1][j] = 5 #3 size
						worldArray[i+2][j] = 1 #reserve spot for 3 size
						worldArray[i+3][j] = 1 #reserve spot for 3 size
					#else:
						#for u in (x-1):
							#worldArray[i+u][j] = 1 #Block further generation attempts

	#Fill in tiles marked in the WorldArray
	for i in xSize:
		for j in ySize:
			if worldArray[i][j] == 2:
				var random_number = rng.randf_range(1.0, 10.0)
				var TilePath = NAVIGABLE_LV_1
				if random_number <= 2.5:
					TilePath = NAVIGABLE_2
				elif random_number > 2.5 and random_number <= 4.0:
					TilePath = NAVIGABLE_SHOP
				elif random_number > 4.0 and random_number <= 6.0:
					TilePath = NAVIGABLE_3
				elif random_number > 6.0 and random_number <= 8:
					TilePath = NAVIGABLE_4
				var worldTile = TilePath.instantiate()
				worldTile.global_position.x = i*128
				worldTile.global_position.y = -j*128
				add_child(worldTile)
			if worldArray[i][j] == 3:
				var random_number = rng.randf_range(1.0, 10.0)
				var TilePath = FEATURE_1_SIZE_1
				if random_number <= 2.5:
					TilePath = FEATURE_1_SIZE_1
				elif random_number > 2.5 and random_number <= 4.0:
					TilePath = FEATURE_1_SIZE_1
				elif random_number > 4.0 and random_number <= 6.0:
					TilePath = FEATURE_1_SIZE_1
				elif random_number > 6.0 and random_number <= 8:
					TilePath = FEATURE_1_SIZE_1
				var worldTile = TilePath.instantiate()
				worldTile.global_position.x = i*128
				worldTile.global_position.y = -j*128
				add_child(worldTile)
				
			if worldArray[i][j] == 4:
				var random_number = rng.randf_range(1.0, 10.0)
				var TilePath = FEATURE_1_SIZE_2
				if random_number <= 2.5:
					TilePath = FEATURE_1_SIZE_2
				elif random_number > 2.5 and random_number <= 4.0:
					TilePath = FEATURE_1_SIZE_2
				elif random_number > 4.0 and random_number <= 6.0:
					TilePath = FEATURE_1_SIZE_2
				elif random_number > 6.0 and random_number <= 8:
					TilePath = FEATURE_1_SIZE_2
				var worldTile = TilePath.instantiate()
				worldTile.global_position.x = i*128 + 64
				worldTile.global_position.y = -j*128
				add_child(worldTile)
				
			if worldArray[i][j] == 5:
				var random_number = rng.randf_range(1.0, 10.0)
				var TilePath = FEATURE_1_SIZE_3
				if random_number <= 2.5:
					TilePath = FEATURE_1_SIZE_3
				elif random_number > 2.5 and random_number <= 4.0:
					TilePath = FEATURE_1_SIZE_3
				elif random_number > 4.0 and random_number <= 6.0:
					TilePath = FEATURE_1_SIZE_3
				elif random_number > 6.0 and random_number <= 8:
					TilePath = FEATURE_1_SIZE_3
				var worldTile = TilePath.instantiate()
				worldTile.global_position.x = i*128 + 128
				worldTile.global_position.y = -j*128
				add_child(worldTile)



const GFS = preload("res://scenes/TileGeneration/GFS.tscn")

#Tiles that generate the 4 runes
const BLUE_RUNE_TERRAIN = preload("res://scenes/TileGeneration/BlueRuneTerrain.tscn")
const GREEN_RUNE_TERRAIN = preload("res://scenes/TileGeneration/GreenRuneTerrain.tscn")
const PURPLE_RUNE_TERRAIN = preload("res://scenes/TileGeneration/PurpleRuneTerrain.tscn")
const RED_RUNE_TERRAIN = preload("res://scenes/TileGeneration/RedRuneTerrain.tscn")

#Tiles that generate pathway to runes
const NAVIGABLE_LV_1 = preload("res://scenes/TileGeneration/NavigableLv1.tscn")
const NAVIGABLE_2 = preload("res://scenes/TileGeneration/Navigable2.tscn")
const NAVIGABLE_SHOP = preload("res://scenes/TileGeneration/NavigableShopKeeper.tscn")
const NAVIGABLE_3 = preload("res://scenes/TileGeneration/Navigable3.tscn")
const NAVIGABLE_4 = preload("res://scenes/TileGeneration/Navigable4.tscn")

#Feature Size 1 tiles
const FEATURE_1_SIZE_1 = preload("res://scenes/TileGeneration/Feature1Size1.tscn")

#Feature Size 2 tiles
const FEATURE_1_SIZE_2 = preload("res://scenes/TileGeneration/Feature1Size2.tscn")

#Feature Size 3 tiles
const FEATURE_1_SIZE_3 = preload("res://scenes/TileGeneration/Feature1Size3.tscn")
