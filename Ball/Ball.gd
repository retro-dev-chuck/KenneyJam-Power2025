class_name Ball extends CharacterBody2D


@export var speed: float = 300.0
var v: Vector2 = Vector2(1, -1).normalized()


func _ready() -> void:
	velocity = v

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta, true)
	if collision:
		handle_bounce(collision)
	else:
		move_and_collide(velocity * speed * delta)
		
		
func handle_bounce(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())
	push_error("BOUNC")
	var collider = collision.get_collider()
	if collider.has_method("apply_damage"):
		collider.call("apply_damage", 1) 
