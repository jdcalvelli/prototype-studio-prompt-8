extends Area2D

var numBalloons:int = 3

func _ready():
	self.body_entered.connect(_on_balloon_entered)

func _on_balloon_entered(body:Node2D):
	numBalloons -= 1
	# change sprite to be one with less balloons
	print(numBalloons)


