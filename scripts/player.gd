class_name Player
extends CharacterBody3D

const WALK_SPEED: float = 12.0
const SPRINT_SPEED: float = 20.0
const JUMP_VELOCITY: float = 7
const SENSITIVITY: float = 0.003

@onready var head: Node3D = $Head
@onready var fall_check: FallCheck = $FallCheck

@export var main_scene: MainScene

var respawn_point: SpawnPoint:
	set(value):
		var current_point: SpawnPoint = fall_check.spawn_point
		if !current_point or current_point.id < value.id:
			fall_check.spawn_point = value
			main_scene.on_new_spawn_point(value)

var collected_coins: int = 0

var _gravity: float = ProjectSettings.get("physics/3d/default_gravity")
var _speed: float

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		head.rotate_x(-event.relative.y * SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if is_on_floor():
		if Input.is_action_pressed("sprint"):
			_speed = SPRINT_SPEED
		else:
			_speed = WALK_SPEED

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * _speed
			velocity.z = direction.z * _speed
		else:
			velocity.x = lerp(velocity.x, direction.x * _speed, delta * 7)
			velocity.z = lerp(velocity.z, direction.z * _speed, delta * 7)
	else:
		velocity.x = lerp(velocity.x, direction.x * _speed, delta * 3)
		velocity.z = lerp(velocity.z, direction.z * _speed, delta * 3)

	move_and_slide()

func on_coin_pickup():
	collected_coins += 1

func on_finished():
	main_scene.on_finish_reached()
