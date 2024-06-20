extends StaticBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var duration_timer = $DurationTimer
@onready var damage_tick = $DamageTick


func _on_hitbox_body_entered(body):
	if animated_sprite_2d.animation != "Warning":
		body.takeDamage()


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "Startup":
		animated_sprite_2d.play("Sustain")


func _on_animated_sprite_2d_animation_looped():
	if animated_sprite_2d.animation == "Startup":
		animated_sprite_2d.play("Sustain")
	if animated_sprite_2d.animation == "Shutdown":
		queue_free()


func _on_warning_timer_timeout():
	if animated_sprite_2d.animation == "Warning":
		animated_sprite_2d.play("Startup")
		duration_timer.start()
		damage_tick.start()


func _on_duration_timer_timeout():
	animated_sprite_2d.play("Shutdown")

func _on_damage_tick_timeout():
	if hitbox.get_collision_mask_value(4) == true:
		hitbox.set_collision_mask_value(4,false)
	else:
		hitbox.set_collision_mask_value(4,true)
