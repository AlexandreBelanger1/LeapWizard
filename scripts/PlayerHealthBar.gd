extends Node2D
@onready var heart = $Hearts/Heart
@onready var heart_2 = $Hearts/Heart2
@onready var heart_3 = $Hearts/Heart3
@onready var heart_4 = $Hearts/Heart4
@onready var heart_5 = $Hearts/Heart5
@onready var heart_6 = $Hearts/Heart6
@onready var half_heart = $Hearts/HalfHeart
@onready var half_heart_2 = $Hearts/HalfHeart2
@onready var half_heart_3 = $Hearts/HalfHeart3
@onready var half_heart_4 = $Hearts/HalfHeart4
@onready var half_heart_5 = $Hearts/HalfHeart5
@onready var half_heart_6 = $Hearts/HalfHeart6

@onready var heart_container = $Containers/HeartContainer
@onready var heart_container_2 = $Containers/HeartContainer2
@onready var heart_container_3 = $Containers/HeartContainer3
@onready var heart_container_4 = $Containers/HeartContainer4
@onready var heart_container_5 = $Containers/HeartContainer5
@onready var heart_container_6 = $Containers/HeartContainer6

@onready var hearts = $Hearts
@onready var containers = $Containers


func setHealth(value):
	var HP = hearts.get_children()
	for j in 12:
		HP[j].visible = false
	for i in value:
		HP[i].visible = true

func setMaxHealth(value):
	var maxHP = containers.get_children()
	for j in 6:
		maxHP[j].visible = false
	for i in value/2:
		maxHP[i].visible = true

