class_name PlayerPaddle extends CombatBody2d
@onready var player_collision: CollisionShape2D = $PlayerCollision

func size() -> float:
	return player_collision.shape.get_rect().size.x
