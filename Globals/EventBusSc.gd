class_name EventBusSc extends Node2D

signal on_enemy_died()
signal on_room_completed()
signal on_place_changed(place_name: String)
signal on_screen_covered()
signal enable_controls()
signal disable_controls()

func fire_enemy_died() -> void:
	on_enemy_died.emit()

func fire_room_completed() -> void:
	on_room_completed.emit()


func fire_place_changed(place_name: String) -> void:
	on_place_changed.emit(place_name)

func fire_screen_covered() -> void:
	on_screen_covered.emit()

func fire_disable_controls() -> void:
	disable_controls.emit()

func fire_enable_controls() -> void:
	enable_controls.emit()
