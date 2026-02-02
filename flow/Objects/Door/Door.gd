class_name Door
extends AnimatedSprite2D

var is_opening:= false

func open_door() -> void:
	is_opening = true
	play("default")
	await animation_finished
	queue_free()

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	if enabled && is_opening:
		play()
	else:
		pause()
