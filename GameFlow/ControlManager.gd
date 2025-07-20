class_name ControlManager extends Node2D

@export var room_transition: RoomTransition
@onready var power_up_canvas_layer: CanvasLayer = $"../PowerUp_CanvasLayer"

func _ready() -> void:
	EventBus.on_room_completed.connect(_disable_controls)
	RoomManager.room_updated.connect(_enable_controls)
	

func _input(_event: InputEvent) -> void:
	if State.is_selecting_power_up:
		if Input.is_action_just_pressed("Door1"):
			Upgrade.upgrade_1()
			State.is_selecting_power_up = false
			State.is_selecting_door = true
			power_up_canvas_layer.visible = false
		elif Input.is_action_just_pressed("Door2"):
			Upgrade.upgrade_2()
			State.is_selecting_power_up = false
			State.is_selecting_door = true
			power_up_canvas_layer.visible = false
		elif Input.is_action_just_pressed("Door3"):
			Upgrade.upgrade_3()
			State.is_selecting_power_up = false
			State.is_selecting_door = true
			power_up_canvas_layer.visible = false
	elif State.is_selecting_door:
		if Input.is_action_just_pressed("Door1") or Input.is_action_just_pressed("Door2") or Input.is_action_just_pressed("Door3"):
			State.is_selecting_door = false
			room_transition.next_room()
		
func _disable_controls() -> void:
	State.is_selecting_power_up = true
	power_up_canvas_layer.visible = true
	EventBus.fire_disable_controls()
	
	
func _enable_controls(_r: Room) -> void:
	EventBus.fire_enable_controls()
