class_name IntroUI
extends Control

@export var main_scene: MainScene

func _on_start_button_pressed() -> void:
	main_scene.on_game_start()
	queue_free()
