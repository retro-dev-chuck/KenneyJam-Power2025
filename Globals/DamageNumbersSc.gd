class_name DamageNumbersSc extends Node2D

const anim_in_dur: float = 0.25
const anim_out_dur: float = 0.35
const move_offset: float = 10
const offset: Vector2 = Vector2(0, -15)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact"):
		display_number(4, Vector2.UP *20)

func display_number(value: float, position: Vector2, is_critical:bool = false) -> void:
	var number = Label.new()
	number.global_position = position + offset
	number.text = String.num(value, 1)
	number.z_index = 100
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_critical:
		color = "#B22"
	if value == 0:
		color = "#FFF8"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 8
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	call_deferred("add_child", number)
	
	await  number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - move_offset , anim_in_dur).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:y", number.position.y, anim_out_dur).set_ease(Tween.EASE_IN).set_delay(anim_in_dur)
	tween.tween_property(number, "scale", Vector2.ZERO, anim_in_dur).set_ease(Tween.EASE_IN).set_delay(anim_out_dur)
	await tween.finished
	number.queue_free()
	
	
