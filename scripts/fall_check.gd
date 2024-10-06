class_name FallCheck
extends Node3D

var spawn_point: SpawnPoint

func _process(_delta: float) -> void:
	if spawn_point and global_position.y < -60:
		get_parent_node_3d().global_position = spawn_point.spawn_position
