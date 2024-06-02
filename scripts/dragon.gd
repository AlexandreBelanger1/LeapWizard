extends CharacterBody2D

const speed = 50


@onready var navigation_agent_2d = $NavigationAgent2D
var target

func _physics_process(_delta: float) -> void:
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	velocity = dir * speed
	move_and_slide()

func makePath() -> void:
	navigation_agent_2d.target_position = target.global_position
	print_debug(navigation_agent_2d.target_position)



func _on_timer_timeout():
	print_debug("timer")
	if target != null:
		makePath()
		print_debug("pathmaking 1")


func _on_aggro_range_body_entered(body):
	target = body
	print_debug("player in range")


func _on_aggro_range_body_exited(_body):
	target = null
