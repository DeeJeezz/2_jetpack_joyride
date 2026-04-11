extends Node2D
class_name GameManager


@export var parallaxes: Array[Parallax2D]


@export_category("Obstacles")
@export var edge_obstacle_scenes: Array[PackedScene]
@export var middle_obstacle_scenes: Array[PackedScene]
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
	Signals.game_over.connect(_on_game_over)


func _spawn_edge_obstacle() -> void:
	var random_obstacle_scene: PackedScene = edge_obstacle_scenes.pick_random()
	var random_obstacle: Node2D = random_obstacle_scene.instantiate()
	
	var spawn_on_floor: bool = false
	if randf() > 0.5:
		spawn_on_floor = true
	
	if spawn_on_floor:
		random_obstacle.rotation_degrees = 180
		random_obstacle.position = Vector2(
			_screen_size.x + 400,
			674,
		)
	else:
		random_obstacle.position = Vector2(
			_screen_size.x + 400,
			30,
		)
	obstacles_container.add_child(random_obstacle)
	
#region Signals
func _on_spawn_obstacle_timer_timeout() -> void:
	# TODO: Random choice between edge and middle screen obstacle.
	_spawn_edge_obstacle()
	spawn_obstacle_timer.start(randf() * 3)
	
	
func _on_coin_pickup() -> void:
	_coins += 1


func _on_game_over() -> void:
	parallaxes.map(func(element): element.autoscroll.x = 0)
	obstacles_container.process_mode = Node.PROCESS_MODE_DISABLED
#endregion
