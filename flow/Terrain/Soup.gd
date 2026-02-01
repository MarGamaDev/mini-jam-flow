class_name SoupTile
extends AnimatedSprite2D

@onready var rand: RandomNumberGenerator = RandomNumberGenerator.new()

var animation_index: String

func Initialize(index: int) -> void:
	animation_index = str(index)
	speed_scale = rand.randf_range(0.8, 1.2);

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	if enabled:
		play(animation_index)
	else:
		pause()
