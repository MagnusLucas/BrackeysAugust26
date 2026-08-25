@tool
class_name EnemySpawner
extends Node2D

const ENEMY = preload("res://scenes/enemy/enemy.tscn")

@export var parent: Node2D
@export var wave_array: Array[Wave]
@export var wave_timer: Timer
@export var spawn_interval_timer: Timer

var current_wave_id := 0
var current_wave: Wave


func _init() -> void:
	if !Engine.is_editor_hint():
		return
	var timer := Timer.new()
	add_child(timer)
	timer.name = "WaveTimer"
	wave_timer = timer
	timer = Timer.new()
	add_child(timer)
	timer.name = "SpawnIntervalTimer"
	spawn_interval_timer = timer


func _ready() -> void:
	if Engine.is_editor_hint():
		wave_timer.owner = get_tree().edited_scene_root
		spawn_interval_timer.owner = get_tree().edited_scene_root
		return
	
	
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	spawn_interval_timer.timeout.connect(_on_interval_timer_timeout)
	if !wave_array.is_empty():
		current_wave = wave_array[0]
		current_wave.spawning_finished.connect(spawn_interval_timer.stop)
		spawn_interval_timer.start(current_wave.get_interval_between_spawns())
		wave_timer.start(current_wave.wave_length)


func _on_wave_timer_timeout() -> void:
	current_wave_id += 1
	if current_wave_id < wave_array.size():
		current_wave = wave_array[current_wave_id]
		current_wave.spawning_finished.connect(spawn_interval_timer.stop)
		spawn_interval_timer.start(current_wave.get_interval_between_spawns())
		wave_timer.start(current_wave.wave_length)


func _on_interval_timer_timeout() -> void:
	spawn_enemy()
	current_wave.register_enemy_spawn()


func spawn_enemy() -> void:
	var enemy := ENEMY.instantiate()
	enemy.modulate = wave_array[current_wave_id].enemy_colour
	parent.add_child(enemy)
