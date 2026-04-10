extends Node2D
class_name GameManager


@export var obstacles_scenes: Array[PackedScene]
@export var obstacles_container: Node2D
@export var spawn_obstacle_timer: Timer


var _screen_size: Vector2


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	
	# Setup signals.
	spawn_obstacle_timer.timeout.connect(_on_spawn_obstacle_timer_timeout)
	spawn_obstacle_timer.start(randf() * 3)


func _spawn_obstacle() -> void:
	var random_obstacle_scene: PackedScene = obstacles_scenes.pick_random()
	var random_obstacle: Node2D = random_obstacle_scene.instantiate()
	var positions = [100, _screen_size.y - 100]
	random_obstacle.position = Vector2(
		_screen_size.x + 400,
		positions.pick_random(),
	)
	obstacles_container.add_child(random_obstacle)
	

func _on_spawn_obstacle_timer_timeout() -> void:
	_spawn_obstacle()
	spawn_obstacle_timer.start(randf() * 3)
