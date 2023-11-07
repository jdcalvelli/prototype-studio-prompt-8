extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# ai states
enum AIStates {
	IDLE,
	CHASE,
}

var currentState:AIStates = AIStates.IDLE
var shouldFall:bool = false
var playerDirection:Vector2

func _ready():
	$Timer.timeout.connect(
		# this is super long it shouldnt be lambda
		func():
			match currentState:
				AIStates.IDLE:
					if position.y > 600:
						shouldFall = true
					elif position.y < -600:
						shouldFall = false
					if !shouldFall:
						velocity.y = JUMP_VELOCITY
				AIStates.CHASE:
					velocity = (JUMP_VELOCITY / 2) * -playerDirection * Vector2(1, 5)
	)
	
	$ChaseDefiner.body_entered.connect(
		func(body:Node2D):
			if body.name == "Player":
				currentState = AIStates.CHASE
				playerDirection = position.direction_to(body.position)
	)
	
	$ChaseDefiner.body_exited.connect(
		func(body:Node2D):
			if body.name == "Player":
				currentState = AIStates.IDLE
	)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if $Balloons.numBalloons <= 0:
		$Timer.stop()
		$CollisionShape2D.disabled = true
	
	move_and_slide()
	
	if velocity.y > 3000 && $Balloons.numBalloons == 0:
		queue_free()
