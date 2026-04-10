extends CharacterBody2D


const JETPACK_VELOCITY: float = 2000


@export var animated_sprite: AnimatedSprite2D
@export var jump_sfx: AudioStreamPlayer2D


func _ready() -> void:
	animated_sprite.play("run")


func _play_animation(name: String) -> void:
	if animated_sprite.animation != name:
		animated_sprite.play(name)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0:
			_play_animation("jump")
		else:
			_play_animation("fall")
	else:
		_play_animation("run")

	# Handle jetpack velocity.
	if Input.is_action_pressed("jump"):
		velocity.y -= JETPACK_VELOCITY * delta
		if is_on_floor():
			jump_sfx.play()
		
	move_and_slide()
