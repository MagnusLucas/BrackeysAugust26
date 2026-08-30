class_name EnemySpawner
extends Node2D

signal all_enemies_died

const ENEMY = preload("res://scenes/enemy/enemy.tscn")

@export var parent: Node2D
@export var wave_manager: WaveManager


var alive_enemies := 0


func _ready() -> void:
	if wave_manager:
		wave_manager.enemy_spawn_requested.connect(_spawn_enemy)


func _spawn_enemy(wave: Wave) -> void:
	var enemy: PathFollow2D = ENEMY.instantiate()
	enemy.modulate = wave.enemy_resource.colour
	var enemy_script: Enemy = enemy.get_child(0)
	enemy_script.died.connect(_on_enemy_died, CONNECT_ONE_SHOT)
	parent.add_child(enemy)
	alive_enemies += 1


func _on_enemy_died() -> void:
	alive_enemies -= 1
	if alive_enemies == 0:
		all_enemies_died.emit()
