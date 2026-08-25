class_name Enemy
extends Area2D

@export var stats: EnemyStats
@export var path_follow: PathFollow2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	if path_follow:
		path_follow.progress += stats.speed * delta


func _take_damage(amount: float) -> void:
	print("ouch!", stats.health, stats.health - amount)
	stats.health -= amount
	if stats.health <= 0:
		_die()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		_take_damage((area as Bullet).get_damage())


func _die() -> void:
	queue_free()
