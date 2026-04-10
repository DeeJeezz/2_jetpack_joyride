extends Node2D
class_name PickableObject


@export var area: Area2D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	
	
func _process_pickup() -> void:
	pass
	
	
func _on_body_entered(_body: Node2D) -> void:
	_process_pickup()
