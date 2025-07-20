class_name Door extends Node2D

@export var closed: Node2D
@export var open: Node2D
@export var locked: Node2D

enum DoorState{
	Closed = 1,
	Open = 1,
	Locked = 2
}

func set_state(state: DoorState) -> void:
	match (state):
		DoorState.Closed:
			closed.visible = true
			open.visible = false
			locked.visible = false
		DoorState.Open:
			closed.visible = false
			open.visible = true
			locked.visible = false
		DoorState.Locked:
			closed.visible = false
			open.visible = false
			locked.visible = true
