extends Area2D
@onready var player_ui = $"../../Camera2D/PlayerUI"



func _on_body_exited(body):
	print_debug("disable stats")
	if(body.name == "Player"):
		player_ui.disableStatsIntro()
		

func _on_body_entered(body):
	print_debug("show stats")
	if(body.name == "Player"):
		player_ui.enableStatsIntro()
