class_name RoomTransition extends Node2D

@export var start_room: PackedScene
@export var rooms: Array[PackedScene]

var current_room_index: int = -1

var current_room: Room

func _ready() -> void:
	EventBus.on_room_completed.connect(_increment_index)
	var first_room: Room = start_room.instantiate() as Room
	first_room.global_position.y = first_room.y_offset
	add_child(first_room)
	await get_tree().process_frame
	RoomManager.room_updated.emit(first_room)
	current_room = first_room
	
	
func _increment_index() -> void:
	current_room_index += 1
	
	
func next_room() -> void:
	if current_room:
		remove_child(current_room)
		current_room.queue_free()
	if current_room_index < rooms.size():
		current_room = rooms[current_room_index].instantiate() as Room
		current_room.global_position.y = current_room.y_offset
		add_child(current_room)
		await get_tree().process_frame
		RoomManager.room_updated.emit(current_room)
