extends Node2D
class_name GameManager


@export var parallaxes: Array[Parallax2D]

@export_category("Obstacles")
@export var edge_obstacle_scenes: Array[PackedScene]
@export var middle_obstacle_scenes: Array[PackedScene]
@export var obstacles_container: Node2D


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
	
	# Connecting signals.
	Signals.coin_pickup.connect(_on_coin_pickup)
	Signals.game_over.connect(_on_game_over)
	Signals.meter_passed.connect(_on_meter_passed)
	Signals.restart_game.connect(_on_restart_game)
	Signals.quit_game.connect(_on_quit_game)

	
#region Signals
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
