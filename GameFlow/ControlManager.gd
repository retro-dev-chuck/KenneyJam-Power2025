class_name ControlManager extends Node2D

@export var room_transition: RoomTransition

func _ready() -> void:
	EventBus.on_room_completed.connect(_disable_controls)
	RoomManager.room_updated.connect(_enable_controls)
	
	
func _disable_controls(_r: Room) -> void:
	EventBus.fire_disable_controls()
	
	
func _enable_controls(_r: Room) -> void:
	EventBus.fire_enable_controls()
