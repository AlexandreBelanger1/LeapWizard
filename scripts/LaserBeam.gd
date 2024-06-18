extends StaticBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var duration_timer = $DurationTimer


func _on_hitbox_body_entered(body):
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
		hitbox.set_collision_mask_value(4,true)
		duration_timer.start()


func _on_duration_timer_timeout():
	animated_sprite_2d.play("Shutdown")
