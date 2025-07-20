class_name Ball extends CharacterBody2D

@export var speed: float = 300.0
@export var damage: Damage
@export var bounce_shake: ShakerComponent2D
@export var damage_shake: ShakerComponent2D

@export var regular_bounce_sfx: AudioStream
@export var paddle_bounce_sfx: AudioStream

var v: Vector2 = Vector2(1, -1).normalized()
var current_damage: Damage

@export var max_simultaneous_bounces: int = 5
var audio_pool: Array[AudioStreamPlayer2D] = []
var audio_index := 0
var bounce_cooldown: float = 0.0

var _can_control: bool = false
var init_pos: Vector2

var bounces_since_last_touch: int = 0

func _ready() -> void:
	init_pos = global_position
	current_damage = damage.duplicate(true)
	EventBus.disable_controls.connect(_disable)
	RoomManager.room_updated.connect(_reset_pos)
	for i in max_simultaneous_bounces:
		var player = AudioStreamPlayer2D.new()
		player.stream = regular_bounce_sfx
		player.autoplay = false
		#player.bus = "SFX"
		add_child(player)
		audio_pool.append(player)

func _reset_pos(_r: Room) -> void:
	global_position = init_pos

func _disable() -> void:
	_can_control = false
	
func _enable() -> void:
	_can_control = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and not _can_control and not State.is_story_playing and not State.is_selecting_door:
		_can_control = true
		velocity = v

func _physics_process(delta: float) -> void:
	if not _can_control:
		velocity = Vector2.ZERO
		return
	if bounce_cooldown > 0.0:
		bounce_cooldown -= delta
	var collision = move_and_collide(velocity * _speed() * delta, true)
	if collision:
		_handle_bounce(collision)
	else:
		move_and_collide(velocity * _speed() * delta)

func _speed() -> float:
	var result: float = speed
	for i in range(Upgrade.upgrade_heavy):
		result = result * 0.75
	return result		

func get_damage() -> float:
	var result: float = current_damage.amount
	result = result + Upgrade.upgrade_heavy + bounces_since_last_touch * 0.25 * Upgrade.upgrade_bounce
	return result
		
func _handle_bounce(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	
	if collider is PlayerPaddle:
		if bounce_cooldown > 0.0:
			return
		
		var paddle: PlayerPaddle = collider
		var paddle_width = paddle.width()
		var paddle_left = paddle.global_position.x - (paddle_width / 2.0)
		var d: float = (collision.get_position().x - paddle_left) / paddle_width
		d = clamp(d, 0.0, 1.0)
		
		var base_angle = (d - 0.5) * PI / 2.0  # -π/4 to +π/4
		
		var paddle_velocity_x = paddle.calculated_velocity_x()
		var influence = clamp(paddle_velocity_x * 0.002, -0.3, 0.3)  # ~±17°
		var angle = base_angle + influence
		
		# Set new ball direction upward at the final angle
		velocity = Vector2(sin(angle), -cos(angle)).normalized()
		
		if abs(velocity.y) < 0.2:
			velocity.y = -0.2  # force it to go up
		velocity = velocity.normalized()
		global_position.y -= 3.0
		
		play_sound(paddle_bounce_sfx)
		bounces_since_last_touch = 0
		if not damage_shake.is_playing and not bounce_shake.is_playing:
			bounce_shake.play_shake()
		bounce_cooldown = 0.3 
			
	else:
		velocity = velocity.bounce(collision.get_normal())
		bounces_since_last_touch += 1
		if collider.has_method("damage"):
			collider.damage(get_damage(), collision.get_position())
			if not damage_shake.is_playing and not bounce_shake.is_playing:
				damage_shake.play_shake()
		else:
			play_sound(regular_bounce_sfx)
			if not damage_shake.is_playing and not bounce_shake.is_playing:
				bounce_shake.play_shake()
				
func play_sound(bounce_sound: AudioStream) -> void:
	if audio_pool.is_empty():
		return

	var player = audio_pool[audio_index]
	audio_index = (audio_index + 1) % audio_pool.size()

	player.stop()
	player.stream = bounce_sound
	player.global_position = global_position
	player.pitch_scale = randf_range(0.9, 1.1)
	player.volume_db = randf_range(-2.0, 0.0)
	player.play()
