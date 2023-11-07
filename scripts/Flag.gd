extends Area2D

func _ready():
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body:Node2D):
	if body.name == "Player":
		# just go to end game
		GameManager.SwitchScene("end")
