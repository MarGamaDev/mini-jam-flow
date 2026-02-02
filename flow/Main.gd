class_name GameManager
extends Node2D

@export var level_count: int = 2
var level_index: int = 1
var current_level

func _ready() -> void:
	_load_next_level()

func _load_next_level() -> void:
	if current_level:
		current_level.queue_free()
	
	if level_index > level_count:
		get_tree().quit()
		return
	
	var level_path: String = "res://Scenes/Level" + str(level_index) + ".tscn"
	var level_scene = load(level_path) as PackedScene
	current_level = level_scene.instantiate()
	add_child(current_level)
	(current_level as Level).level_end.connect(on_level_end)

func on_level_end(has_won: bool) -> void:
	if has_won:
		level_index += 1
	
	_load_next_level()
