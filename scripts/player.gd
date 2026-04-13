extends RigidBody2D
class_name Player


const _FLOOR_GROUP_NAME: String = "Floor"
const _OBSTACLE_GROUP_NAME: String = "Obstacle"
const JETPACK_VELOCITY: float = 2200


@export var animated_sprite: AnimatedSprite2D

@export var distance_timer: Timer

@export_category("SFX")
@export var jump_sfx: AudioStreamPlayer2D
@export var death_sfx: AudioStreamPlayer2D

var _is_on_floor: bool = true


func _ready() -> void:
	animated_sprite.play("run")


func _play_animation(animation_name: String) -> void:
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)


func death() -> void:
	distance_timer.timeout.disconnect(_on_distance_timer_timeout)
	Signals.game_over.emit()
	death_sfx.play()
	visible = false
	await death_sfx.finished
	queue_free()


func _process(delta: float) -> void:
	# Add the gravity.
	if not _is_on_floor:
		linear_velocity += get_gravity() * delta
		if linear_velocity.y < 0:
			_play_animation("jump")
		else:
			_play_animation("fall")
	else:
		_play_animation("run")

	# Handle jetpack velocity.
	if Input.is_action_pressed("jump"):
		linear_velocity.y -= JETPACK_VELOCITY * delta
		if _is_on_floor:
			jump_sfx.play()
			_is_on_floor = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(_OBSTACLE_GROUP_NAME):
		death()
	elif body.is_in_group(_FLOOR_GROUP_NAME):
		_is_on_floor = true


func _on_distance_timer_timeout() -> void:
	Signals.meter_passed.emit()
