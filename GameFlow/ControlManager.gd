class_name ControlManager extends Node2D

@export var room_transition: RoomTransition

func _ready() -> void:
	EventBus.on_room_completed.connect(_disable_controls)
	RoomManager.room_updated.connect(_enable_controls)
	

func _input(_event: InputEvent) -> void:
	if State.is_selecting_door:
		if Input.is_action_just_pressed("Door1") or Input.is_action_just_pressed("Door2") or Input.is_action_just_pressed("Door3"):
			room_transition.next_room()
			State.is_selecting_door = false
			
func _disable_controls() -> void:
	State.is_selecting_door = true
	EventBus.fire_disable_controls()
	
	
func _enable_controls(_r: Room) -> void:
	EventBus.fire_enable_controls()
