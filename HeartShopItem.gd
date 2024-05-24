extends Node2D
@onready var game_manager = $".."
@onready var info_button = $InfoButton
@onready var info_panel = $InfoPanel
@onready var info_button_close = $InfoButtonClose
@onready var buy_label = $BuyLabel
@onready var item_sprite = $ItemSprite
@onready var info_label = $InfoPanel/InfoLabel

var ItemArray

var ItemDict= {"HEART": 0,
"HALF_HEART": 1, 
"HEART_CONTAINER" : 2,
"LMB_COOLDOWN_ITEM" : 3,
"LMB_DAMAGE_UP_ITEM":4,
"LMB_MANA_DECREASE_ITEM" : 5,
"RMB_COOLDOWN_ITEM" : 6,
"RMB_DAMAGE_UP_ITEM" : 7,
"RMB_MANA_DECREASE_ITEM" : 8,
"EXTRA_JUMP_ITEM" : 9
}

var SpriteDict= {"HEART": "res://assets/sprites/Heart.png",
"HALF_HEART": "res://assets/sprites/HalfHeart.png", 
"HEART_CONTAINER" : "res://assets/sprites/HeartContainerItem.png",
"LMB_COOLDOWN_ITEM" : "res://assets/sprites/LMBCooldownItem.png",
"LMB_DAMAGE_UP_ITEM":"res://assets/sprites/LMBDamageUpItem.png",
"LMB_MANA_DECREASE_ITEM" : "res://assets/sprites/LMBManaDecreaseItem.png",
"RMB_COOLDOWN_ITEM" : "res://assets/sprites/RMBCooldownItem.png",
"RMB_DAMAGE_UP_ITEM" : "res://assets/sprites/RMBDamageUpItem.png",
"RMB_MANA_DECREASE_ITEM" : "res://assets/sprites/RMBManaDecreaseItem.png",
"EXTRA_JUMP_ITEM" :"res://assets/sprites/ExtraJumpItem.png"
}

var DescriptionsDict = {"HEART": "Restore 1 Heart",
"HALF_HEART": "Restore 1/2 Heart", 
"HEART_CONTAINER" : "+1 Maximum Hearts",
"LMB_COOLDOWN_ITEM" : "-10% Cooldown on spell slot 1",
"LMB_DAMAGE_UP_ITEM":"+10% Damage on spell slot 1",
"LMB_MANA_DECREASE_ITEM" : "-10% Mana cost on spell slot 1",
"RMB_COOLDOWN_ITEM" : "-10% Cooldown on spell slot 2",
"RMB_DAMAGE_UP_ITEM" : "+10% Damage on spell slot 2",
"RMB_MANA_DECREASE_ITEM" : "-10% Mana cost on spell slot 2",
"EXTRA_JUMP_ITEM" :"+1 Mid-air jumps"}

var playerOnItem = false
var itemName = "test"

func _on_item_area_body_entered(body):
	info_button.visible = true
	buy_label.visible = true


func _on_item_area_body_exited(body):
	info_button.visible = false
	info_panel.visible = false
	info_button_close.visible = false
	buy_label.visible = false


func _on_info_button_pressed():
	info_panel.visible = true
	info_button.visible = false
	info_button_close.visible = true


func _on_info_button_close_pressed():
	info_panel.visible = false
	info_button.visible = true
	info_button_close.visible = false

func buyItem(name):
	var item = load(ItemDict[name])

func setSprite(name):
	item_sprite.texture = load(SpriteDict[name])

func setInfo(name):
	info_label.text = DescriptionsDict[name]
