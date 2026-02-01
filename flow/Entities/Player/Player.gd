class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 500;
@export var orb_minimum_distance: float = 9;

var time_orb: TimeOrb;
var is_in_time: bool = false;

func initialize(orb: TimeOrb):
	time_orb = orb

func _process(delta: float) -> void:
	animated_sprite_2d.flip_h = velocity.dot(Vector2.RIGHT) < 0

func _physics_process(delta: float) -> void:
	if !is_in_time:
		return
	
	velocity = Vector2.ZERO
	print((time_orb.global_position - global_position).length())
	if (time_orb.global_position - global_position).length() > orb_minimum_distance:
		velocity = (time_orb.global_position - global_position).normalized() * move_speed * delta
	move_and_slide()

func update_timezone(enabled: bool) -> void:
	is_in_time = enabled;
	
	if is_in_time:
		animated_sprite_2d.play("Idle")
		return;
	
	animated_sprite_2d.pause()
