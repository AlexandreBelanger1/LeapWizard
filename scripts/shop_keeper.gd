extends Node2D
@onready var shop_ui = $ShopUI
@onready var add_button = $ShopUI/AddButton
@onready var add_button_2 = $ShopUI/AddButton2
@onready var add_button_3 = $ShopUI/AddButton3
@onready var game_manager = $"../.."
@onready var tooltip_1_background = $ShopUI/AddButton/Item1/Tooltip1Background
@onready var tooltip_2_background = $ShopUI/AddButton2/Item2/Tooltip2Background
@onready var tooltip_3_background = $ShopUI/AddButton3/Item3/Tooltip3Background
@onready var press_e_to_shop = $"press E to shop"

var insideShopFlag = false

func _on_area_2d_body_entered(body):
	if(body.name=="Player"):
		press_e_to_shop.visible = true
		insideShopFlag = true


func _on_area_2d_body_exited(body):
	if(body.name=="Player"):
		press_e_to_shop.visible = false
		insideShopFlag = false
		shop_ui.visible = false

func _input(event):
	if event.is_action_pressed("Interact") and insideShopFlag:
		if shop_ui.visible:
			shop_ui.visible = false
			press_e_to_shop.visible = true
		else:
			shop_ui.visible = true
			press_e_to_shop.visible = false



#Shop Costs
var Cost1 = 30
var Cost2 = 20
var Cost3 = 50

func _on_add_button_pressed():
	if(game_manager.get_player_score() >= Cost1):
		#pay cost in eggs
		game_manager.remove_points(Cost1)
		#gain item / effect from shop
		game_manager.add_player_damage(1)


func _on_add_button_2_pressed():
	if(game_manager.get_player_score() >= Cost2):
		#pay cost in eggs
		game_manager.remove_points(Cost2)
		#gain item / effect from shop
		game_manager.changeHealth(game_manager.get_player_maxHP()-game_manager.get_player_HP())


func _on_add_button_3_pressed():
	if(game_manager.get_player_score() >= Cost3):
		#pay cost in eggs
		game_manager.remove_points(Cost3)
		#gain item / effect from shop
		game_manager.addJumps(1)

#Shop Item Tooltips enable on hover

func _on_item_1_hover_mouse_entered():
	tooltip_1_background.visible = true


func _on_item_1_hover_mouse_exited():
	tooltip_1_background.visible = false


func _on_item_2_hover_mouse_entered():
	tooltip_2_background.visible = true


func _on_item_2_hover_mouse_exited():
	tooltip_2_background.visible = false


func _on_item_3_hover_mouse_entered():
	tooltip_3_background.visible = true


func _on_item_3_hover_mouse_exited():
	tooltip_3_background.visible = false
