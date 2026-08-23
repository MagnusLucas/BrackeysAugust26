class_name Enemy
extends PathFollow2D

@export var enemy_stats: EnemyStats


func _physics_process(delta: float) -> void:
	progress += enemy_stats.speed * delta
