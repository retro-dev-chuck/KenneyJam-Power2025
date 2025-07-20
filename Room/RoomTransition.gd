class_name RoomTransition extends Node2D

@export var start_room: PackedScene
@export var rooms: Array[PackedScene]


func _ready() -> void:
	var first_room: Room = start_room.instantiate() as Room
	first_room.global_position.y = first_room.y_offset
	add_child(first_room)
	await get_tree().process_frame
	RoomManager.room_updated.emit(first_room)
