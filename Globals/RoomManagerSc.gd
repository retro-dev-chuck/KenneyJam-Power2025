class_name RoomManagerSc extends Node2D

signal room_updated(room: Room)

func fire_room_updated(room: Room) -> void:
	room_updated.emit(room)
	
