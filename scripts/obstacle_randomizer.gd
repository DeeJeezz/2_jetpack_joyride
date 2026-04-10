extends Node2D
class_name ObstacleRandomizer


@export_category("Settings")
@export var min_y: float
@export var max_y: float

@export_category("Nodes")
@export var target: Node2D
@export var target_collision: CollisionShape2D


func _ready() -> void:
	target.position.y = randf_range(min_y, max_y)
	var scale_modifier = randf_range(target.scale.y - 0.05, target.scale.y + 0.05)
	target.scale.y = scale_modifier
	target_collision.position = target.position
	target_collision.scale += Vector2(scale_modifier, scale_modifier)
