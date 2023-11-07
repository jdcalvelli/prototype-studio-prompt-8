extends Node

# objects
var normalPlatform:PackedScene = preload("res://prefabs/platform.tscn")
var candlePlatform:PackedScene = preload("res://prefabs/candle_platform.tscn")

# arrays
var normalPlatformArray:Array[PackedScene]
var candlePlatformArray:Array[PackedScene]

# sizes
var normalPlatformArraySize:int = 16
var candlePlatformArraySize:int = 3

func InitGame():
	
	for i in range(normalPlatformArraySize):
		normalPlatformArray.append(normalPlatform)
		var platformToAdd = normalPlatformArray[i].instantiate()
		platformToAdd.position = Vector2(randi_range(200, 2200), randi_range(-600, 600))
		get_tree().root.call_deferred("add_child", platformToAdd)
	
	for i in range(candlePlatformArraySize):
		candlePlatformArray.append(candlePlatform)
		var platformToAdd = candlePlatformArray[i].instantiate()
		platformToAdd.position = Vector2(randi_range(200, 1800), randi_range(-600, 600))
		get_tree().root.call_deferred("add_child", platformToAdd)

func RemoveObjects():
	normalPlatformArray.clear()
	candlePlatformArray.clear()
	

func SwitchScene(nextScene:String):
	match nextScene:
		"game":
			get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
		"end":
			get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
	
