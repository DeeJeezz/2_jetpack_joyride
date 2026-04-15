extends Node2D
class_name MovingObject

var _destroy_border_x: float = -50.0


func _ready() -> void:
	_destroy_border_x -= get_viewport_rect().size.x 


func _process(delta: float) -> void:
	position.x -= GameGlobals.base_game_speed * delta
	if position.x <= _destroy_border_x:
		queue_free()
 
