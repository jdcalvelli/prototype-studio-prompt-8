extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if $Balloons.numBalloons > 0:
		# Handle Jump.
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# smoother screen wrap
		if position.x <= -(get_viewport_rect().size.x / 2) - $Sprite2D.texture.get_width():
			position.x = get_viewport_rect().size.x / 2
		elif position.x >= (get_viewport_rect().size.x / 2) + $Sprite2D.texture.get_width():
			position.x = -(get_viewport_rect().size.x / 2)
	elif $Balloons.numBalloons <= 0:
		$CollisionShape2D.disabled = true

	move_and_slide()
