extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body:Node2D):
	if body.name == "Player":
		body.get_node("Timer").start(6.0)
		if body.obstructionState < 2:
			body.obstructionState += 1
			print(body.obstructionState)
		# bring it up so that its post fog of war
		z_index = 2

