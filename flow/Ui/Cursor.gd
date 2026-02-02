class_name CustomCursor
extends AnimatedSprite2D

enum MouseStates {
	idle = 0,
	hover = 1,
	hold = 2,
}

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D/CollisionShape2D

var current_state: MouseStates = MouseStates.idle
var grabables: Array[Node2D]

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	_update_state()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode =Input.MOUSE_MODE_CONFINED_HIDDEN
	else:
		Input.mouse_mode =Input.MOUSE_MODE_HIDDEN

func _update_state() -> void:
	if !grabables.is_empty():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			current_state = MouseStates.hold;
		else:
			current_state = MouseStates.hover;
	else:
		current_state = MouseStates.idle
	
	frame = current_state;

func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Grabable") && !grabables.has(body):
		grabables.append(body);

func _on_collision_shape_2d_body_exited(body: Node2D) -> void:
	if grabables.has(body):
		grabables.erase(body);
