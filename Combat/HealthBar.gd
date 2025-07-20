class_name HealthBar extends ProgressBar


@export var combat_manager: CombatManager

func _ready() -> void:
	combat_manager.on_health_updated.connect(_on_health_updated)
	await get_tree().process_frame
	init_bar()

func init_bar() -> void:
	max_value = combat_manager.current_hp.amount
	value = max_value
	min_value = 0

func _on_health_updated(current_val: float) -> void:
	value = current_val
