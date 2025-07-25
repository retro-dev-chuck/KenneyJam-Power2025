class_name Room extends Node2D

enum RoomType{
	Square = 0,
	Wide = 1,
	Narrow = 2
}
@export var place: String = "Unnamed Place"
@export var room_type: RoomType = RoomType.Square
@export var min_x: float = min_default
@export var max_x: float = max_default
@export var y_offset: float = 240

const min_default: float = -560
const max_default: float = 560

func get_min() -> float:
	match (room_type):
		RoomType.Square:
			return -560
		RoomType.Wide:
			return -750
		RoomType.Narrow:
			return -250
	push_warning("Return default min val")
	return -560
			
func get_max() -> float:
	match (room_type):
		RoomType.Square:
			return 560
		RoomType.Wide:
			return 750
		RoomType.Narrow:
			return 250
	push_warning("Return default max val")
	return 560
