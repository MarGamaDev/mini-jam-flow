class_name GameManager
extends Node2D

const TIME_SHADER_MATERIAL = preload("uid://yjrxvhfw04t4")

@onready var time_orb: TimeOrb = $"Time Orb"
@onready var player: Player = $Player

@export var time_area_radius: float = 50

func _ready() -> void:
	TIME_SHADER_MATERIAL.set_shader_parameter("time_area_radius", time_area_radius)
	time_orb.set_radius(time_area_radius)
	player.initialize(time_orb)

func _process(_delta: float) -> void:
	TIME_SHADER_MATERIAL.set_shader_parameter("time_area_coords", time_orb.global_position)

func _on_time_orb_entity_entered(area: Area2D) -> void:
	area.update_timezone(true);

func _on_time_orb_entity_exited(area: Area2D) -> void:
	area.update_timezone(false);
