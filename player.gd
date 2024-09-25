extends CharacterBody3D

@export var speed = 14
@export var fall_acelleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	# normalize velocity
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(direction)
	
	if direction != Vector3.ZERO:
		# ground velocity
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
		
		# vertical velocity
		if not is_on_floor():  # If in the air, fall towards the floor. Literally gravity
			target_velocity.y = target_velocity.y - (fall_acelleration * delta)
		
		# moving character
		velocity = target_velocity
		move_and_slide()
