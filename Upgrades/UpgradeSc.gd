class_name UpgradeSc extends Node2D

@export var upgrade_bounce: int = 0
@export var upgrade_speed: int = 0
@export var upgrade_heavy: int = 0


func upgrade_1() -> void:
	upgrade_bounce += 1

func upgrade_2() -> void:
	upgrade_speed += 1

func upgrade_3() -> void:
	upgrade_heavy += 1
	print("Heavy upgraded to: " + str(upgrade_heavy))
