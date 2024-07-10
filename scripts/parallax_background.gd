extends Node2D
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer
@onready var parallax_layer_2 = $ParallaxBackground/ParallaxLayer2

func ChangeBrightness(value: float):
	parallax_layer.modulate = Color.from_hsv(0,0,value)
	parallax_layer_2.modulate = Color.from_hsv(0,0,value)
