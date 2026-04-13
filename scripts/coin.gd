extends PickableObject
class_name Coin

const _NORMAL_PITCH_SCALE: float = 1.0
const _PITCH_SCALE_STEP: float = 0.05


@export var sfx: AudioStreamPlayer2D
@export var area: Area2D


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	Signals.coin_pickup.emit()
	visible = false
	var last_coin_picked_up_at: float = Time.get_ticks_msec() - GameStats.last_coin_picked_up_at
	if last_coin_picked_up_at < 150:
		GameStats.last_coins_picked_up += 1
		sfx.pitch_scale += _PITCH_SCALE_STEP * GameStats.last_coins_picked_up
	else:
		GameStats.last_coins_picked_up = 0
	sfx.play()
	GameStats.last_coin_picked_up_at = Time.get_ticks_msec()
	await sfx.finished
	queue_free()
