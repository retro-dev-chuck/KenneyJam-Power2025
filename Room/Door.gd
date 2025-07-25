class_name Door extends Node2D

@export var closed: Node2D
@export var open: Node2D
@export var locked: Node2D
@export var label: Label

@export var current_state: DoorState = DoorState.Closed
var no: int = 0
enum DoorState{
	Closed = 0,
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
			label.visible = true
		DoorState.Locked:
			closed.visible = false
			open.visible = false
			locked.visible = true

func set_no(_no: int) -> void:
	no = _no
	label.text = str(no)
	
