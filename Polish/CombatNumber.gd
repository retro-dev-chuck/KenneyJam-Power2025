class_name CombatNumber extends Node2D

@export var combat_manager: CombatManager

func _ready() -> void:
	combat_manager.on_damaged.connect(_on_damaged)
	combat_manager.on_died.connect(_on_died)
	if not combat_manager.owner:
		push_error("Combat manager owner is null!")
	
func _on_damaged(amount: float, pos: Vector2) -> void:
	DamageNumbers.display_number(amount, pos)

func _on_died(amount: float, pos: Vector2) -> void:
	DamageNumbers.display_number(amount, pos)
