class_name Glorpis
extends StaticBody2D

@onready var FIREBALL = preload("uid://uhi10bh8bu81")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2d

enum GlorpDirection {LEFT, RIGHT, DOWN, UP}
@export var glorp_direction: GlorpDirection

var fire_direction: Vector2
var time_between_shots: float = 3
var timer: float = 0
var frozen:= true
var firing:= false

func _ready() -> void:
	match glorp_direction:
		GlorpDirection.LEFT:
			fire_direction = Vector2.LEFT
		GlorpDirection.RIGHT:
			fire_direction = Vector2.RIGHT
		GlorpDirection.DOWN:
			fire_direction = Vector2.DOWN
		GlorpDirection.UP:
			fire_direction = Vector2.UP

func _process(delta: float) -> void:
	if frozen || firing:
		return
	
	timer += delta
	if timer >= time_between_shots:
		shoot_fireball()

func shoot_fireball() -> void:
	firing = true
	timer = 0
	
	animated_sprite_2d.play("fire")
	await animated_sprite_2d.animation_finished
	
	var fireball = FIREBALL.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(fireball)
	(fireball as Fireball).shoot(fire_direction, self)
	
	animated_sprite_2d.play("idle")


func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	frozen = !enabled
	if enabled:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.pause()
