extends Area2D

@export var adversaryName:String
var numBalloons:int = 3

func _ready():
	$AnimatedSprite2D.frame = 2
	self.body_entered.connect(_on_balloon_entered)

func _on_balloon_entered(body:Node2D):
	if body.name == adversaryName || body.name.contains("Platform"):
		numBalloons -= 1
		# print(numBalloons)
		# change sprite to be one with less balloons
		$AnimatedSprite2D.frame = numBalloons - 1
	if numBalloons == 0:
		visible = false
 

