class_name EventBusSc extends Node2D

signal on_enemy_died()
signal on_room_completed()


func fire_enemy_died() -> void:
	on_enemy_died.emit()

func fire_room_completed() -> void:
	on_room_completed.emit()
