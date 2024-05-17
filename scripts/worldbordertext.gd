extends Area2D

@onready var rich_text_label = $RichTextLabel
func _on_body_entered(body):
	rich_text_label.visible = true



func _on_body_exited(body):
	rich_text_label.visible = false
