class_name MainScene
extends Node3D

@onready var player: Player = %Player
@onready var spawn_point: SpawnPoint = $SpawnPoint1
@onready var game_ui: GameUI = %GameUI
@onready var finish_ui: FinishUI = %FinishUI

var player_time: String:
	get: return game_ui.time

func _ready() -> void:
	get_tree().paused = true
	player.respawn_point = spawn_point

func on_game_start() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	game_ui.set_visible(true)
	game_ui.on_game_started()
	get_tree().paused = false

func on_new_spawn_point(point: SpawnPoint) -> void:
	game_ui.on_checkpoint_set(point)

func on_finish_reached() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	game_ui.on_game_ended()
	game_ui.set_visible(false)
	get_tree().paused = true
	finish_ui.update_time(player_time)
	finish_ui.set_visible(true)

func on_restart() -> void:
	get_tree().reload_current_scene()
