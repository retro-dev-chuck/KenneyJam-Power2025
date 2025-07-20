class_name PlayerPaddle extends CombatBody2d
@onready var player_collision: CollisionShape2D = $PlayerCollision
@onready var player_movement: PlayerMovement = $PlayerMovement

func width() -> float:
	return player_collision.shape.get_rect().size.x

func calculated_velocity_x() -> float:
	return player_movement.calculated_velocity.x
