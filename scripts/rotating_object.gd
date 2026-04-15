extends Node2D

@export var speed: float = 15.0


func _process(delta: float) -> void:
	rotation_degrees += speed * delta
