class_name Lantern
extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal lantern_lit
var lit:= false

func light() -> void:
	if lit:
		return
	
	animated_sprite_2d.play("default")
	await animated_sprite_2d.animation_finished
	lit = true
	lantern_lit.emit()
	animated_sprite_2d.play("On")

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	if enabled && lit:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.pause()
