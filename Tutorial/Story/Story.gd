class_name Story extends Node

@export var ui: StoryUi

var intro: Array[String] =\
["Welcome to training grounds!",\
"Break the bricks to get access to the dungeon",\
"Defeat the demon king and become a hero!"]

func _ready() -> void:
	if not SaveManager.save_data or not SaveManager.save_data.is_story_shown:
		ui.show_messages(intro)
		SaveManager.save_data = SaveData.new()
		SaveManager.save_data.is_story_shown = true
		SaveManager.save()
