class_name Door
extends AnimatedSprite2D

func open_door() -> void:
	play("default")
	await animation_finished
	queue_free()
