class_name Door
extends AnimatedSprite2D

var unlocked:= false
var is_frozen:= true
var is_opening = false

func _process(_delta: float) -> void:
	if is_frozen || !unlocked:
		return
	
	if !is_opening:
		open_door()

func open_door() -> void:
	is_opening = true
	play("default")
	await animation_finished
	queue_free()

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	is_frozen = !enabled
	if !is_frozen && unlocked:
		play()
	else:
		pause()

func _on_button_stepped_on_button() -> void:
	unlocked = true

func _on_lantern_lantern_lit() -> void:
	unlocked = true
