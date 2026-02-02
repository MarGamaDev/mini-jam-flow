class_name TimeOrb
extends CharacterBody2D

@export var follow_speed: float = 30;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var half_width: Vector2 = Vector2(8,8)

var TIMEZONE_RADIUS = preload("uid://jwj61sfwd8fr")

signal entity_entered(area: Area2D);
signal entity_exited(area: Area2D);


var dragging: bool = false
var mouse_inside: bool = false
var is_unlocked: bool = true
var drag_offset: Vector2 = Vector2.ZERO

var rune_target: Vector2 = Vector2.ZERO

func _ready() -> void:
	animated_sprite_2d.play("Idle")

func _process(_delta: float) -> void:
	var mouse_pressed: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT);
	
	if mouse_inside && mouse_pressed:
		dragging = true;
	
	if !mouse_pressed:
		dragging = false;

func _physics_process(_delta: float) -> void:
	if !is_unlocked:
		velocity = (rune_target - global_position) * follow_speed;
		move_and_slide()
		global_position = global_position.clamp(Vector2.ZERO + half_width, screen_size - half_width)
		return
	
	var mouse_position: Vector2 = get_global_mouse_position()
	if dragging:
		var target_position = mouse_position + drag_offset;
		velocity = (target_position - global_position) * follow_speed;
	else:
		drag_offset = global_position - mouse_position;
		velocity *= 0.95
	
	move_and_slide()
	global_position = global_position.clamp(Vector2.ZERO + half_width, screen_size - half_width)

func _on_mouse_entered() -> void:
	mouse_inside = true;

func _on_mouse_exited() -> void:
	mouse_inside = false;

func _on_timezone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Entity"):
		entity_entered.emit(area);

func _on_timezone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Entity"):
		entity_exited.emit(area);

func set_radius(radius: float) -> void:
	TIMEZONE_RADIUS.radius = radius

func yoink_orb(rune_position: Vector2) -> void:
	animated_sprite_2d.speed_scale = 15
	is_unlocked = false
	rune_target = rune_position
