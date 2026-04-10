extends Node2D
class_name GameManager


@export var obstacles_scenes: Array[PackedScene]
@export var obstacles_container: Node2D
@export var spawn_obstacle_timer: Timer


var _screen_size: Vector2
var _coins: int = 0


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	
	# Setup signals.
	spawn_obstacle_timer.timeout.connect(_on_spawn_obstacle_timer_timeout)
	spawn_obstacle_timer.start(randf() * 3)
	
	# Connecting signals.
	Signals.coin_pickup.connect(_on_coin_pickup)


func _spawn_obstacle() -> void:
	var random_obstacle_scene: PackedScene = obstacles_scenes.pick_random()
	var random_obstacle: Node2D = random_obstacle_scene.instantiate()
	random_obstacle.position = Vector2(
		_screen_size.x + 400,
		randf_range(0, _screen_size.y),
	)
	obstacles_container.add_child(random_obstacle)
	
#region Signals
func _on_spawn_obstacle_timer_timeout() -> void:
	_spawn_obstacle()
	spawn_obstacle_timer.start(randf() * 3)
	
	
func _on_coin_pickup() -> void:
	_coins += 1
	print(_coins)
#endregion
