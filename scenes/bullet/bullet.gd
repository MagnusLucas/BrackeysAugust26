class_name Bullet
extends Area2D

const BULLET = preload("uid://ccm10bmhcxkc7")

@export var lifetime_timer: Timer
var speed := 100.0
var direction: Vector2
var damage: float


static func spawn_bullet(
		bullet_speed: float, fly_direction: Vector2,
		lifetime: float, bullet_damage: float) -> Bullet:
	var bullet: Bullet = BULLET.instantiate()
	bullet.speed = bullet_speed
	bullet.direction = fly_direction
	bullet.lifetime_timer.wait_time = lifetime
	bullet.damage = bullet_damage
	return bullet


func _ready() -> void:
	lifetime_timer.timeout.connect(queue_free, CONNECT_ONE_SHOT)
	area_entered.connect(_on_enemy_entered)


func get_damage() -> float:
	return damage


func _process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_enemy_entered(_enemy: Enemy) -> void:
	queue_free()
