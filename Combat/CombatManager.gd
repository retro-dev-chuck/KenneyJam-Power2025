class_name CombatManager extends Node2D

signal on_health_updated(hp: float)
signal on_damaged(amount: float, pos: Vector2)
signal on_died(amount: float, pos: Vector2)


@export var target: Node2D
@export var health_res: Health

var current_hp: Health

func _ready() -> void:
	current_hp = health_res.duplicate(true)
	
func apply_damage(damage: Damage, pos: Vector2) -> void:
	if current_hp.amount == 0:
		return
	var pre_amount: float = current_hp.amount
	current_hp.amount = max(0, current_hp.amount - damage.amount)
	on_health_updated.emit(current_hp.amount)
	if current_hp.amount == 0:
		on_died.emit(pre_amount, pos)
	elif pre_amount != current_hp.amount:
		on_damaged.emit(pre_amount - current_hp.amount, pos)
