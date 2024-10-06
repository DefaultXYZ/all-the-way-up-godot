class_name FinishPoint
extends Node3D

func _on_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.on_finished()
