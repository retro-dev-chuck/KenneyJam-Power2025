class_name Ball extends CharacterBody2D

@export var speed: float = 300.0
@export var damage: Damage
@export var bounce_shake: ShakerComponent2D
@export var damage_shake: ShakerComponent2D

var v: Vector2 = Vector2(1, -1).normalized()
var current_damage: Damage


func _ready() -> void:
	current_damage = damage.duplicate(true)
	velocity = v

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta, true)
	if collision:
		handle_bounce(collision)
	else:
		move_and_collide(velocity * speed * delta)
		
		
func handle_bounce(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())
	var collider = collision.get_collider()
	var has_just_triggered: bool = false
	if collider is PlayerPaddle:
		var paddle: PlayerPaddle = collider

		var offset = (global_position.x - paddle.global_position.x) / (paddle.size() / 2.0)
		offset = clamp(offset, -1.0, 1.0)

		var max_bounce_angle = deg_to_rad(60)
		var angle = lerp(-max_bounce_angle, max_bounce_angle, (offset + 1.0) / 2.0)

		velocity = Vector2(cos(angle), -sin(angle)).normalized()
	else:
		if collider.has_method("damage"):
			print("damage found " + str(collider))
			collider.damage(current_damage, collision.get_position())
			if not damage_shake.is_playing:
				damage_shake.play_shake()
				has_just_triggered = true
		else:
			print("damage not found " + str(collider))
	
	if not has_just_triggered and (not damage_shake.is_playing and not bounce_shake.is_playing):
		bounce_shake.play_shake()
