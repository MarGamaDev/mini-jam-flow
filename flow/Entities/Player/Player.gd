class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

@export var move_speed: float = 500;
@export var orb_minimum_distance: float = 9;

signal player_death

var time_orb: TimeOrb
var is_in_time: bool = false
var dead: bool = false

func initialize(orb: TimeOrb):
	time_orb = orb

func _process(_delta: float) -> void:
	animated_sprite_2d.flip_h = velocity.dot(Vector2.RIGHT) < 0

func _physics_process(_delta: float) -> void:
	if !is_in_time && !dead:
		velocity = Vector2.ZERO
		return
	
	navigation_agent_2d.target_position = time_orb.global_position
	var next_position = navigation_agent_2d.get_next_path_position()
	var target_velocity = global_position.direction_to(next_position) * move_speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.velocity = target_velocity
	else:
		_on_navigation_agent_2d_velocity_computed(target_velocity)
	move_and_slide()

func update_timezone(enabled: bool) -> void:
	is_in_time = enabled;
	
	if is_in_time && !dead:
		animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.pause()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func light() -> void:
	animated_sprite_2d.play("Death")
	await animated_sprite_2d.animation_finished
	player_death.emit()
