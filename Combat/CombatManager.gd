class_name CombatManager extends Node2D

signal on_health_updated(hp: float)
signal on_damaged(amount: float, pos: Vector2)
signal on_pre_death()
signal on_died(amount: float, pos: Vector2)


@export var target: Node2D
@export var health_res: Health

var current_hp: Health

func _ready() -> void:
	current_hp = health_res.duplicate(true)
	
func apply_damage(damage: float, pos: Vector2) -> void:
	if current_hp.amount == 0:
		return
	var pre_amount: float = current_hp.amount
	current_hp.amount = max(0, current_hp.amount - damage)
	on_health_updated.emit(current_hp.amount)
	if current_hp.amount == 0:
		on_pre_death.emit()
		on_died.emit(damage, pos)
	elif pre_amount != current_hp.amount:
		on_damaged.emit(damage, pos)
