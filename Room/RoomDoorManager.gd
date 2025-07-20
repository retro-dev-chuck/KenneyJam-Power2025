class_name RoomDoorManager extends Node2D

var doors: Array[Door] = []
@export var open_door: AudioStream
@export var audio_player: AudioStreamPlayer2D
@export var is_completed: bool = false

func _ready() -> void:
	EventBus.on_room_completed.connect(_open_closed_doors)
	await get_tree().process_frame
	_init_doors()

func _init_doors() -> int: 
	doors.clear()
	var count := 0
	for child in get_parent().get_children():
		if child is Door:
			var door = child as Door
			door.set_no(doors.size()+1)
			doors.append(door)
			
	return count	

func _open_closed_doors() -> void:
	for door in doors:
		if door.current_state == Door.DoorState.Closed:
			door.set_state(Door.DoorState.Open)
	if audio_player:
		if audio_player.playing:
			audio_player.stop()
		
		audio_player.stream = open_door
		audio_player.global_position = global_position
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.volume_db = randf_range(-2.0, 0.0)
		audio_player.play()
		
	is_completed = true
