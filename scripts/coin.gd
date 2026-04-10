extends PickableObject
class_name Coin


func _process_pickup() -> void:
	Signals.coin_pickup.emit()
	queue_free()
