class_name WaveManager
extends Node

signal last_wave_finished_spawning
signal enemy_spawn_requested(wave: Wave)

@export var wave_array: Array[Wave]
@export var wave_timer: Timer
@export var spawn_interval_timer: Timer

var current_wave_id := 0
var current_wave: Wave


func _ready() -> void:
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	spawn_interval_timer.timeout.connect(_on_interval_timer_timeout)
	if !wave_array.is_empty():
		current_wave = wave_array[0]
		current_wave.spawning_finished.connect(spawn_interval_timer.stop)
		spawn_interval_timer.start(current_wave.get_interval_between_spawns())
		wave_timer.start(current_wave.wave_length)
		wave_array[wave_array.size() - 1].spawning_finished.connect(last_wave_finished_spawning.emit)


func is_last_wave() -> bool:
	return current_wave_id == wave_array.size()


func get_wave_array() -> Array[Wave]:
	return wave_array


func _on_wave_timer_timeout() -> void:
	current_wave_id += 1
	if current_wave_id < wave_array.size():
		current_wave = wave_array[current_wave_id]
		current_wave.spawning_finished.connect(spawn_interval_timer.stop)
		spawn_interval_timer.start(current_wave.get_interval_between_spawns())
		wave_timer.start(current_wave.wave_length)


func _on_interval_timer_timeout() -> void:
	enemy_spawn_requested.emit(current_wave)
	current_wave.register_enemy_spawn()
