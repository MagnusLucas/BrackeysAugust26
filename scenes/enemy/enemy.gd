class_name Enemy
extends Area2D

signal died

@export var stats: EnemyStats
@export var path_follow: PathFollow2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var alive := true


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	if path_follow and alive:
		path_follow.progress += stats.speed * delta


func take_damage(amount: float) -> void:
	stats.health -= amount
	if stats.health <= 0:
		_die()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		take_damage((area as Bullet).get_damage())


func _die() -> void:
	alive = false
	animated_sprite_2d.play("death")
	animated_sprite_2d.animation_finished.connect(
		func():
			died.emit()
			queue_free(),
			CONNECT_ONE_SHOT
	)
