extends CharacterBody2D


const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			if velocity.y < 0 and velocity.y > -200:
				velocity.y -= 100
		
	move_and_slide()
