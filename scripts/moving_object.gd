extends Node2D
class_name MovingObject

@export var speed: float = 400.0

var _destroy_border_x: float = -50.0


func _ready() -> void:
	_destroy_border_x -= get_viewport_rect().size.x 


func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x <= _destroy_border_x:
		queue_free()
 
