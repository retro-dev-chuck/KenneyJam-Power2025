class_name CombatBody2d extends CharacterBody2D

@export var combat_manager: CombatManager

func damage(damage: Damage, pos: Vector2) -> void:
	combat_manager.apply_damage(damage, pos)
