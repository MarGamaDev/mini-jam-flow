class_name GameManager
extends Node2D

@export var level_count: int = 2
var level_index: int = 0
var current_level

func _ready() -> void:
	_load_next_level()

func _load_next_level() -> void:
	if current_level:
		current_level.queue_free()
	
	level_index += 1
	
	if level_index > level_count:
		return
	
	var level_path: String = "res://Scenes/Level" + str(level_index) + ".tscn"
	var level_scene = load(level_path) as PackedScene
	current_level = level_scene.instantiate()
	add_child(current_level)
	(current_level as Level).game_end.connect(_load_next_level)
