extends Node2D

const _DESTROY_BORDER: float = -50.0

@export var speed: float = 400.0
@export var obstacle_object: Node2D


func _process(delta: float) -> void:
	obstacle_object.position.x -= speed * delta
	if obstacle_object.position.x <= _DESTROY_BORDER:
		obstacle_object.queue_free()
