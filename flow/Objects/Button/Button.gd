class_name FloorButton
extends AnimatedSprite2D

signal stepped_on_button
var triggered := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player") || triggered:
		return
	
	frame = 1
	stepped_on_button.emit()
