extends Area2D
func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		var boss = BOSSpath.instantiate()
		boss.global_position = global_position
		boss.nextPosition = body.position
		boss.name = "Boss"
		get_parent().add_child(boss)
		tile_map.set_layer_enabled(3,true)
		queue_free()

func _on_body_entered(body):
	pass # Replace with function body.
