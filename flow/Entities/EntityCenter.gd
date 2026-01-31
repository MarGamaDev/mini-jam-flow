class_name EntityCenter
extends Area2D

signal on_update_timezone(enabled: bool)

func update_timezone(enabled: bool):
	on_update_timezone.emit(enabled)
