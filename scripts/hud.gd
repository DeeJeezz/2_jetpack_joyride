extends CanvasLayer
class_name HUD


@export var score_label: Label
@export var coins_label: Label


func set_score(score: int) -> void:
	score_label.text = "%s m" % score
	
	
func set_coins(coins: int) -> void:
	coins_label.text = "%s" % coins
