class_name SpawnPoint
extends Node3D

@export var id: int = -1
@export var respawn_node: Node3D

var spawn_position: Vector3:
	get: return respawn_node.global_position

var fall_bound_y: float:
	get: return respawn_node.global_position.y - 15

func _on_spawn_point_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.respawn_point = self
