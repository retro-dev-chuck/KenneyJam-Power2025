class_name PlaceName extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $PanelContainer/MarginContainer/Label

var current_place: String = "None"

func _ready() -> void:
	RoomManager.room_updated.connect(room_updated)
	
func room_updated(r: Room) -> void:
	if r and r.place and r.place.length() > 0 and r.place != current_place:
		new_place(r.place)	

func new_place(place_name: String) -> void:
	current_place = place_name
	label.text = current_place
	animation_player.play("appear")
