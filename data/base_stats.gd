class_name BaseStats
extends Resource

signal lost_all_health

@export var max_hp := 3

var hp := max_hp : set = set_health


func set_health(value) -> void:
	hp = value
	if hp == 0:
		lost_all_health.emit()
