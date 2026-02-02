class_name Fireball
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var speed: float = 20
var move_direction: Vector2
var frozen = true
var exploding = false

func shoot(direction: Vector2, parent_body: Node2D) -> void:
	add_collision_exception_with(parent_body)
	move_direction = direction
	global_position = parent_body.global_position + (direction * 8)
	
	match direction:
		Vector2.LEFT:
			animated_sprite_2d.play("horizontal")
		Vector2.RIGHT:
			animated_sprite_2d.play("horizontal")
			animated_sprite_2d.flip_h = true
		Vector2.UP:
			animated_sprite_2d.play("vertical")
		Vector2.DOWN:
			animated_sprite_2d.play("vertical")
			animated_sprite_2d.flip_v = true
	
	if frozen:
		animated_sprite_2d.pause()

func _physics_process(delta: float) -> void:
	if frozen || exploding:
		velocity = Vector2.ZERO
		return
	
	var collision = move_and_collide(move_direction * speed * delta)
	if collision:
		var object = collision.get_collider() as Node2D
		if object.is_in_group("Flammable"):
			object.light()
		
		exploding = true
		explode()

func explode() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("explode")
	await animated_sprite_2d.animation_finished
	queue_free()

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	frozen = !enabled
	if enabled:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.pause()
