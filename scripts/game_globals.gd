extends Node


var last_coin_picked_up_at: float = 0.0
var last_coins_picked_up: int = 0

var current_score: int = 0
var record_score: int = 0
var current_coins: int = 0


var base_game_speed: float = 600.0


func start_game() -> void:
	SaveManager.load_last_session()
	current_score = 0
	record_score = SaveManager.last_session.get("max_score", 0)
	current_coins = SaveManager.last_session.get("coins", 0)


func save_game() -> void:
	if current_score > record_score:
		record_score = current_score
	SaveManager.save_current_session(
		 {
			"coins": current_coins,
			"last_score": current_score,
			"max_score": record_score,
		}
	)


func increase_game_speed() -> void:
	base_game_speed += 100
	Signals.game_speed_increased.emit()
