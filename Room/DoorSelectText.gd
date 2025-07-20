class_name DoorSelectText extends Label


func _ready() -> void:
	EventBus.disable_controls.connect(_appear)
	EventBus.enable_controls.connect(_disappear)

func _appear() -> void:
	visible = true

func _disappear() -> void:
	visible = false
