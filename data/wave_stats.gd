class_name Wave
extends Resource

signal spawning_finished
signal enemy_spawned

@export var enemy_colour: Color
@export var number_of_enemies: int
@export var wave_length: float
## Shorter than wave length...
@export var spawn_time: float

var enemies_spawned := 0


func get_interval_between_spawns() -> float:
	return spawn_time / number_of_enemies


func register_enemy_spawn() -> void:
	enemies_spawned += 1
	enemy_spawned.emit()
	if enemies_spawned == number_of_enemies:
		spawning_finished.emit()
