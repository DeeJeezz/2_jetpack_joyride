extends CharacterBody2D


const JETPACK_VELOCITY: float = 2000


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jetpack velocity.
	if Input.is_action_pressed("jump"):
		velocity.y -= JETPACK_VELOCITY * delta
		
	move_and_slide()
