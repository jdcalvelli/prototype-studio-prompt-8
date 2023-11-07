extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var obstructionState : int = 2

func _ready():
	$Timer.timeout.connect(
		func():
			if obstructionState > 0:
				obstructionState -= 1
			print("timeout")
	)

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
	elif $Balloons.numBalloons <= 0:
		$CollisionShape2D.disabled = true

	# setting obstructors
	$Camera2D/Obstructor.texture = $Camera2D/Obstructor.ObstructorSprites[obstructionState]

	move_and_slide()
	
	# scene swap based on velocity
	if velocity.y > 3000 && $Balloons.numBalloons == 0:
		GameManager.SwitchScene("end")
	elif velocity.y > 5000:
		GameManager.SwitchScene("end")
