class_name CombatBody2d extends CharacterBody2D

@export var combat_manager: CombatManager

func damage(_damage: float, _pos: Vector2) -> void:
	combat_manager.apply_damage(_damage, _pos)
