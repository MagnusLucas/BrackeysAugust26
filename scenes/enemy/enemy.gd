class_name Enemy
extends Area2D

@export var enemy_stats: EnemyStats
@export var path_follow: PathFollow2D


func _physics_process(delta: float) -> void:
	if path_follow:
		path_follow.progress += enemy_stats.speed * delta


func take_damage() -> void:
	print("ouch! - ", self)
