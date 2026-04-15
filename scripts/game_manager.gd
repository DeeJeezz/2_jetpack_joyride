extends Node2D
class_name GameManager


@export_category("Timers")
@export var distance_timer: Timer
@export var obstacle_spawn_timer: Timer

@export_category("Obstacles")
@export var obstacle_scenes: Array[PackedScene]
@export var obstacles_container: Node2D

@export_category("UI")
@export var hud: HUD
@export var ui: UI


var _screen_size: Vector2
var _coins: int:
	get:
		return GameGlobals.current_coins
	set(value):
		GameGlobals.current_coins = value
		hud.set_coins(_coins)
		
var _score: int:
	get:
		return GameGlobals.current_score
	set(value):
		GameGlobals.current_score = value
		hud.set_score(_score)


func _ready() -> void:
	# Setup game.
	_score = 0
	GameGlobals.start_game()
	_setup_timers()
	distance_timer.start()
	obstacle_spawn_timer.start()
	_coins = GameGlobals.current_coins
	_screen_size = get_viewport_rect().size
	
	# Connecting signals.
	Signals.coin_pickup.connect(_on_coin_pickup)
	Signals.game_over.connect(_on_game_over)
	Signals.restart_game.connect(_on_restart_game)
	Signals.quit_game.connect(_on_quit_game)


func _setup_timers() -> void:
	distance_timer.wait_time = GameGlobals.base_game_speed / 6000
	obstacle_spawn_timer.wait_time = GameGlobals.base_game_speed / 200


func _spawn_obstacle() -> void:
	var obstacle_scene: PackedScene = obstacle_scenes.pick_random()
	var obstacle: MovingObject = obstacle_scene.instantiate()
	obstacle.position.x = _screen_size.x + GameGlobals.base_game_speed
	if randf() > 0.5:
		obstacle.rotation_degrees = 180
		obstacle.position.x *= 2
		obstacle.position.y = _screen_size.y
	obstacles_container.add_child(obstacle)
	obstacle_spawn_timer.start()

	
#region Signals
func _on_coin_pickup() -> void:
	_coins += 1
	
	
func _on_meter_passed() -> void:
	_score += 1
	if _score % 25 == 0:
		GameGlobals.increase_game_speed()
		_setup_timers()


func _on_obstacle_spawn_timer_timeout() -> void:
	_spawn_obstacle()


func _on_game_over() -> void:
	get_tree().paused = true
	GameGlobals.save_game()
	ui.game_over(_score, GameGlobals.record_score)
	

func _on_restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_quit_game() -> void:
	get_tree().paused = false
	get_tree().quit()
#endregion
