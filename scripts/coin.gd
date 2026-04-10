extends PickableObject
class_name Coin


@export var sfx: AudioStreamPlayer2D
@export var area: Area2D


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		sfx.play()
		visible = false
		await sfx.finished
		queue_free()
