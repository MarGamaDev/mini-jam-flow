class_name Bat
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var player: Player

var speed = 40
var frozen := true
var dead := false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	if frozen || dead:
		return
	
	velocity = global_position.direction_to(player.global_position) * speed
	move_and_slide()
	for i in get_slide_collision_count():
		var collision_object = get_slide_collision(i).get_collider() as Node
		if collision_object.is_in_group("Player"):
			collision_object.light()
			light()

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	frozen = !enabled
	if enabled && !dead:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.pause()

func light() -> void:
	if dead:
		return
	
	collision_shape_2d.disabled = true
	dead = true
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
