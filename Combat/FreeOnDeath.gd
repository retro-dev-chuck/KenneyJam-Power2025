class_name FreeOnDeath extends Node2D

@export var combat_manager: CombatManager
@export var free_target: Node2D

func _ready() -> void:
	combat_manager.on_died.connect(_on_dead)
	
	
func _on_dead(amount: float, pos: Vector2) -> void:
	free_target.queue_free()
