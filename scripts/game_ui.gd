class_name GameUI
extends Control

@onready var time_label: Label = %TimeLabel
@onready var checkpoint_label: Label = %CheckpointLabel

var is_time_on: bool = false

var elapsed: float = 0

var minutes: float = 0
var seconds: float = 0
var millis: float = 0

var time: String = ""

func _process(delta: float) -> void:
	if is_time_on:
		elapsed += delta
		minutes = elapsed / 60
		seconds = fmod(elapsed, 60)
		millis = fmod(elapsed, 1) * 100
		time = "%02d:%02d.%02d" % [minutes, seconds, millis]
		time_label.text = str("Time: ", time)

func on_game_started() -> void:
	is_time_on = true

func on_game_ended() -> void:
	is_time_on = false

func on_checkpoint_set(point: SpawnPoint) -> void:
	if point.id != 0:
		checkpoint_label.set_visible(true)
		await get_tree().create_timer(2).timeout
		checkpoint_label.set_visible(false)
