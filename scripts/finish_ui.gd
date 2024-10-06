class_name FinishUI
extends Control

@onready var time_label: Label = %TimeLabel

@export var main_scene: MainScene

func update_time(time: String) -> void:
	time_label.text = str("Your final time is: ", time)

func _on_retry_button_pressed() -> void:
	main_scene.on_restart()
