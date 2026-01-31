class_name TimeOrb
extends CharacterBody2D

@export var follow_speed: float = 30;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var TIMEZONE_RADIUS = preload("uid://jwj61sfwd8fr")

signal entity_entered(area: Area2D);
signal entity_exited(area: Area2D);

var dragging: bool = false
var mouse_inside: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	animated_sprite_2d.play("Idle");

func _process(_delta: float) -> void:
	var mouse_pressed: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT);
	
	if mouse_inside && mouse_pressed:
		dragging = true;
	
	if !mouse_pressed:
		dragging = false;

func _physics_process(delta: float) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	if dragging:
		var target_position = mouse_position + drag_offset;
		velocity = (target_position - global_position) * follow_speed * delta;
		move_and_slide()
	else:
		drag_offset = global_position - mouse_position;

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
