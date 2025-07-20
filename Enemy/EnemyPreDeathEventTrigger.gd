class_name EnemyPreDeathEventTrigger extends Node2D

@onready var combat_manager: CombatManager = $"../CombatManager"

var has_fired_event: bool = false

func _ready() -> void:
	combat_manager.on_pre_death.connect(_pre_death)
	
func _pre_death() -> void:
	if has_fired_event:
		return
	has_fired_event = true
	EventBus.on_enemy_died.emit()
