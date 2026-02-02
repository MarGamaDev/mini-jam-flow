class_name Lilypad
extends Sprite2D

@onready var path: Path2D = $"../.."
@onready var path_follow_2d: PathFollow2D = $".."

@export var nav_links: Array[NavigationLink2D]
@export var move_speed: float = 25

var frozen:= true
var traveling:= false
var direction: int = 1

var player: Node2D

func _physics_process(delta: float) -> void:
	for link in nav_links:
		link.enabled = !traveling
	
	if !traveling || frozen:
		return
	
	path_follow_2d.progress += direction * move_speed * delta
	
	if path_follow_2d.progress_ratio >= 1:
		path_follow_2d.progress_ratio = 1
		direction = -1
		traveling = false
		for link in nav_links:
			link.enabled = true
	
	if path_follow_2d.progress_ratio <= 0:
		path_follow_2d.progress_ratio = 0
		direction = -1
		traveling = false
		for link in nav_links:
			link.enabled = true

func _on_entity_center_on_update_timezone(enabled: bool) -> void:
	frozen = !enabled

func _on_player_trigger_body_entered(body: Node2D) -> void:
	if traveling || !body.is_in_group("Player"):
		return
	
	if !player:
		body.call_deferred("reparent", self)
		player = body
	
	traveling = true


func _on_player_trigger_body_exited(body: Node2D) -> void:
	if traveling || !body.is_in_group("Player"):
		return
	
	var level = get_tree().get_first_node_in_group("Level")
	if player:
		body.call_deferred("reparent", level)
		player = null
