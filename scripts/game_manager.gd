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
	_score = 0
	GameGlobals.start_game()
	_coins = GameGlobals.current_coins
	
	_screen_size = get_viewport_rect().size
	
	# Connecting signals.
	Signals.coin_pickup.connect(_on_coin_pickup)
	Signals.game_over.connect(_on_game_over)
	Signals.restart_game.connect(_on_restart_game)
	Signals.quit_game.connect(_on_quit_game)

	
#region Signals
func _on_coin_pickup() -> void:
	_coins += 1
	
	
func _on_meter_passed() -> void:
	_score += 1
	if _score % 100 == 0:
		GameGlobals.increase_game_speed()


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
