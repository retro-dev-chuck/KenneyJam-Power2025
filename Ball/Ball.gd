class_name Ball extends CharacterBody2D

@export var speed: float = 300.0
@export var damage: Damage

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
	if collider.has_method("damage"):
		print("damage found " + str(collider))
		collider.damage(current_damage)
	else:
		print("damage not found " + str(collider))
