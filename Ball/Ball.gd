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


func _ready() -> void:
	current_damage = damage.duplicate(true)
	velocity = v
	for i in max_simultaneous_bounces:
		var player = AudioStreamPlayer2D.new()
		player.stream = regular_bounce_sfx
		player.autoplay = false
		#player.bus = "SFX"
		add_child(player)
		audio_pool.append(player)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta, true)
	if collision:
		_handle_bounce(collision)
	else:
		move_and_collide(velocity * speed * delta)
		
		
func _handle_bounce(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())
	var collider = collision.get_collider()
	var has_just_damaged: bool = false
	if collider is PlayerPaddle:
		var paddle: PlayerPaddle = collider

		var offset = (global_position.x - paddle.global_position.x) / (paddle.size() / 2.0)
		offset = clamp(offset, -1.0, 1.0)

		var max_bounce_angle = deg_to_rad(60)
		var angle = lerp(-max_bounce_angle, max_bounce_angle, (offset + 1.0) / 2.0)

		velocity = Vector2(cos(angle), -sin(angle)).normalized()
		
		play_sound(paddle_bounce_sfx)
		
		if not damage_shake.is_playing and not bounce_shake.is_playing:
			bounce_shake.play_shake()
			
	else:
		if collider.has_method("damage"):
			print("damage found " + str(collider))
			collider.damage(current_damage, collision.get_position())
			if not damage_shake.is_playing and not bounce_shake.is_playing:
				damage_shake.play_shake()
			has_just_damaged = true
		else:
			print("damage not found " + str(collider))
			
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
