class_name SaveManagerSc extends Node2D

const SAVE_PATH := "user://save_data.tres"

var save_data: SaveData

func _ready():
	load_data()

func load_data():
	if ResourceLoader.exists(SAVE_PATH):
		var s = ResourceLoader.load(SAVE_PATH) as SaveData
		if not s:
			save_data = SaveData.new()
			save()
	else:
		save_data = SaveData.new()
		save()

func save():
	if not save_data:
		save_data = SaveData.new()
	var err := ResourceSaver.save(save_data, SAVE_PATH)
	if err != OK:
		push_error("Save failed with code %d" % err)

		
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("DeleteSave"):
			delete_save_file()
			
			
func delete_save_file() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
		print("Save file deleted!")
	else:
		print("No save file to delete.")
