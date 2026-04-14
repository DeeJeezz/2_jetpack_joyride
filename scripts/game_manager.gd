extends Node2D
class_name GameManager


@export var parallaxes: Array[Parallax2D]

@export_category("Obstacles")
@export var edge_obstacle_scenes: Array[PackedScene]
@export var middle_obstacle_scenes: Array[PackedScene]
@export var obstacles_container: Node2D
@export var spawn_obstacle_timer: Timer


@export_category("UI")
@export var hud: HUD
@export var ui: UI


var _screen_size: Vector2
var _coins: int: 
	set(value):
		_coins = value
		hud.set_coins(_coins)
		
var _score: int:
	set(value):
		_score = value
		hud.set_score(_score)


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	SaveManager.load_last_session()
	_coins = SaveManager.last_session.get("coins", 0)
	_score = 0
	# Setup signals.
	spawn_obstacle_timer.timeout.connect(_on_spawn_obstacle_timer_timeout)
	spawn_obstacle_timer.start(randf() * 3)
	
	# Connecting signals.
	Signals.coin_pickup.connect(_on_coin_pickup)
	Signals.game_over.connect(_on_game_over)
	Signals.meter_passed.connect(_on_meter_passed)
	Signals.restart_game.connect(_on_restart_game)
	Signals.quit_game.connect(_on_quit_game)


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
	
	
func _on_meter_passed() -> void:
	_score += 1


func _on_game_over() -> void:
	get_tree().paused = true
	
	var last_max_score: int = SaveManager.last_session.get("max_score", 0)
	if _score > last_max_score:
		last_max_score = _score
		
	ui.game_over(_score, last_max_score)
	SaveManager.save_current_session(
		 {
			"coins": _coins,
			"last_score": _score,
			"max_score": last_max_score,
		}
	)
	

func _on_restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_quit_game() -> void:
	get_tree().paused = false
	get_tree().quit()
#endregion
