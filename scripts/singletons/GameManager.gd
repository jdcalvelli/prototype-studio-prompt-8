extends Node

func SwitchScene(nextScene:String):
	match nextScene:
		"game":
			get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
		"end":
			get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
	
