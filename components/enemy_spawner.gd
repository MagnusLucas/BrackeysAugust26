class_name EnemySpawner
extends Node2D

const ENEMY = preload("res://scenes/enemy/enemy.tscn")

@export var parent: Node2D
@export var wave_manager: WaveManager


func _ready() -> void:
	if wave_manager:
		wave_manager.enemy_spawn_requested.connect(_spawn_enemy)


func _spawn_enemy(wave: Wave) -> void:
	var enemy := ENEMY.instantiate()
	enemy.modulate = wave.enemy_resource.colour
	parent.add_child(enemy)
