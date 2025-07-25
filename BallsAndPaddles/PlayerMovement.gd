class_name PlayerMovement extends Node2D

@export var character_body: CharacterBody2D
@export var speed = 800.0

var _min: float = Room.min_default
var _max: float = Room.max_default
var calculated_velocity: Vector2 = Vector2.ZERO
var start_y: float 

var _can_control: bool = false

func _ready() -> void:
	EventBus.disable_controls.connect(_disable)
	EventBus.enable_controls.connect(_enable)
	RoomManager.room_updated.connect(_on_room_updated)
	_on_room_updated(null)
	start_y = global_position.y

func _disable() -> void:
	_can_control = false
	
func _enable() -> void:
	_can_control = true

func _physics_process(delta: float) -> void:
	if !_can_control:
		character_body.velocity = Vector2.ZERO
		return
	var direction := Input.get_axis("Left", "Right")
	if direction:
		character_body.velocity.x = direction * speed
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, speed)

	if character_body.velocity.x > 0 and character_body.position.x + character_body.velocity.x * delta > _max:
		character_body.velocity.x = 0
		
	if character_body.velocity.x < 0 and character_body.position.x + character_body.velocity.x * delta < _min:
		character_body.velocity.x = 0
		
	calculated_velocity = character_body.velocity

	character_body.move_and_slide()
	global_position.y = start_y

func _on_room_updated(room: Room) -> void:
	if room:
		_min = room.get_min()
		_max = room.get_max()
	else:
		_min = Room.min_default
		_max = Room.max_default
