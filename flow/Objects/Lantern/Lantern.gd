class_name Lantern
extends AnimatedSprite2D

signal lantern_lit

func light() -> void:
	play("default")
	await animation_finished
	lantern_lit.emit()
	play("On")



func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	if enabled:
		play()
	else:
		pause()
