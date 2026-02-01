class_name GameManager
extends Node2D

const TIME_SHADER_MATERIAL = preload("uid://yjrxvhfw04t4")

@onready var time_orb: TimeOrb = $"Time Orb"
@onready var player: Player = $Player

@onready var soup: TileMapLayer = $Soup
@onready var soup_bowl: Node2D = $"Soup Bowl"
const SOUP_TILE = preload("uid://b72oeph4tcfxj")

@export var time_area_radius: float = 50

func _ready() -> void:
	TIME_SHADER_MATERIAL.set_shader_parameter("time_area_radius", time_area_radius)
	time_orb.set_radius(time_area_radius)
	player.initialize(time_orb)
	
	# configure soup
	for position in soup.get_used_cells():
		var data = soup.get_cell_tile_data(position)
		var index: int = data.get_custom_data("soup_index")
		if index != 5:
			var tile: SoupTile = SOUP_TILE.instantiate();
			soup_bowl.add_child(tile)
			tile.global_position = Vector2(position.x * 16 + 8, position.y * 16 + 8)
			tile.Initialize(index)
			soup.erase_cell(position)

func _process(_delta: float) -> void:
	TIME_SHADER_MATERIAL.set_shader_parameter("time_area_coords", time_orb.global_position)

func _on_time_orb_entity_entered(area: Area2D) -> void:
	area.update_timezone(true);

func _on_time_orb_entity_exited(area: Area2D) -> void:
	area.update_timezone(false);
