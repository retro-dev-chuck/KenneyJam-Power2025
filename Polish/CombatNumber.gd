class_name CombatNumber extends Node2D

@export var combat_manager: CombatManager

func _ready() -> void:
	combat_manager.on_damaged.connect(_on_damaged)
	combat_manager.on_died.connect(_on_died)
	if not combat_manager.owner:
		push_error("Combat manager owner is null!")
	
func _on_damaged(amount: float) -> void:
	DamageNumbers.display_number(amount, global_position)

func _on_died(amount: float) -> void:
	DamageNumbers.display_number(amount, global_position)
