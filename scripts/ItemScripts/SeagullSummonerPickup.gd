extends Node2D

func _on_area_2d_body_entered(body):
	body.seagullPickup()
	call_deferred("free")
