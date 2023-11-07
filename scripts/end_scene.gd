extends Node2D

func _ready():
	GameManager.RemoveObjects()

func _input(event):
	if event.is_action_pressed("restart"):
		print("restart")
		GameManager.SwitchScene("game")
