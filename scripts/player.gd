extends RigidBody2D
class_name Player


const _FLOOR_GROUP_NAME: String = "Floor"
const _CEILING_GROUP_NAME: String = "Ceiling"
const _OBSTACLE_GROUP_NAME: String = "Obstacle"
const JETPACK_VELOCITY: float = 2100


@export var animated_sprite: AnimatedSprite2D

@export_category("VFX")
@export var fly_particles: GPUParticles2D

@export_category("SFX")
@export var jump_sfx: AudioStreamPlayer2D
@export var death_sfx: AudioStreamPlayer2D

var _is_on_floor: bool = true


func _ready() -> void:
	animated_sprite.play("run")
	fly_particles.emitting = false


func _play_animation(animation_name: String) -> void:
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)


func death() -> void:
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
			fly_particles.emitting = false
	else:
		_play_animation("run")

	# Handle jetpack velocity.
	if Input.is_action_pressed("jump"):
		linear_velocity.y -= JETPACK_VELOCITY * delta
		if _is_on_floor:
			jump_sfx.play()
			_is_on_floor = false
		else:
			fly_particles.emitting = true


func _on_body_entered(body: Node2D) -> void:
	# Touch obstacle.
	if body.is_in_group(_OBSTACLE_GROUP_NAME):
		death()
	# Touch floor.
	elif body.is_in_group(_FLOOR_GROUP_NAME):
		_is_on_floor = true
		linear_velocity.y = 0
	# Touch ceiling.
	elif body.is_in_group(_CEILING_GROUP_NAME):
		linear_velocity.y = get_gravity().y / 4
