class_name PlayerMovement extends Node2D

@export var character_body: CharacterBody2D
@export var speed = 800.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	if direction:
		character_body.velocity.x = direction * speed
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, speed)
		
	character_body.move_and_slide()
