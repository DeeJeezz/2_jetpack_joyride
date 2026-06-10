extends CanvasLayer
class_name UI


@export_category("Panels")
@export var game_over_panel: Panel
@export var start_game_panel: Panel

@export_category("Labels")
@export var current_score_label: Label
@export var max_score_label: Label


func _ready() -> void:
	game_over_panel.hide()
	start_game_panel.show()
	
	
func start_game() -> void:
	start_game_panel.hide()


func game_over(current_score: int, max_score: int) -> void:
	game_over_panel.show()
	current_score_label.text = "Current score: %s" % current_score
	max_score_label.text = "Max score: %s" % max_score


func _on_restart_button_button_down() -> void:
	Signals.restart_game.emit()


func _on_quit_button_button_down() -> void:
	Signals.quit_game.emit()
