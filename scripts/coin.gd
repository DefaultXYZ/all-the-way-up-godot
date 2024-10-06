class_name Coin
extends Node3D

@onready var mesh: MeshInstance3D = $Mesh
@onready var collect_detector: Area3D = $CollectDetector

func _process(delta: float) -> void:
	mesh.rotate_y(2 * delta)

func _on_collect_detector_body_entered(body: Node3D) -> void:
	if body is Player: _handle_player_entered(body)

func _handle_player_entered(player: Player):
	player.on_coin_pickup()
	queue_free()
