class_name CombatBody2d extends CharacterBody2D

@export var combat_manager: CombatManager

func damage(damage: Damage) -> void:
	combat_manager.apply_damage(damage)
