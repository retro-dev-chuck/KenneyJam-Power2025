class_name DamageLogger extends Node2D

@export var combat_manager: CombatManager

func _ready() -> void:
	combat_manager.on_damaged.connect(_on_damaged)
	if not combat_manager.owner:
		push_error("Combat manager owner is null!")
	
func _on_damaged(amount: float) -> void:
	push_warning(combat_manager.target.name + " damaged " + String.num(amount, 1))
