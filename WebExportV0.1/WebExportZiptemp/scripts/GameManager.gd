extends Node
@onready var game_manager = %GameManager
@onready var score_label = $"../Camera2D/ScoreLabel"



var score = 0

func add_point():
	score += 1
	score_label.text = "score: " + str(score) 
