class_name RoomEnemyManager extends Node2D

func _ready() -> void:
	EventBus.on_enemy_died.connect(check_for_room_completion)

func get_live_enemy_count() -> int: 
	var count := 0
	for child in get_parent().get_children():
		if child is CombatBody2d:
			count += 1
	return count

func check_for_room_completion() -> void:
	await get_tree().create_timer(1.0).timeout
	if get_live_enemy_count() == 0:
		EventBus.fire_room_completed()
		print("Completed!")
