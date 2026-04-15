extends Parallax2D
class_name GlobalSpeedParallax


@export var speed_multiplier: float = 1.0


func _setup_parallax_speed() -> void:
	autoscroll.x = -GameGlobals.base_game_speed * speed_multiplier


func _ready() -> void:
	Signals.game_speed_increased.connect(_on_game_speed_increased)
	_setup_parallax_speed()


func _on_game_speed_increased() -> void:
	_setup_parallax_speed()
