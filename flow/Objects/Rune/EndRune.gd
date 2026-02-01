class_name EndRune
extends Node2D

signal OnOrbPresent


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Orb"):
		(body as TimeOrb).yoink_orb(global_position)
	OnOrbPresent.emit()
