class_name GameManager
extends Node2D

@onready var time_shader: ColorRect = $CanvasLayer/Control/TimeShader
@onready var time_orb: CharacterBody2D = $"Time Orb"

@export var time_area_radius: float = 50

func _ready() -> void:
	time_shader.material.set_shader_parameter("time_area_radius", time_area_radius)

func _process(_delta: float) -> void:
	time_shader.material.set_shader_parameter("time_area_coords", time_orb.global_position)
