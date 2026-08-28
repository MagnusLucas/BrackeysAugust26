class_name Tower
extends Node2D

@export var tower_stats: TowerStats : set = set_stats

var enemies_in_range: Array[Enemy]

@onready var attack_range: AttackRange = $AttackRange
@onready var attack_interval_timer: Timer = $AttackIntervalTimer
@onready var bullet_spawner: Node2D = $BulletSpawner


func _ready() -> void:
	attack_range.area_entered.connect(_on_attack_range_enemy_entered)
	attack_range.area_exited.connect(_on_attack_range_enemy_exited)
	attack_interval_timer.timeout.connect(shoot)


func set_stats(value) -> void:
	tower_stats = value
	if !tower_stats:
		return
	if is_node_ready():
		attack_interval_timer.wait_time = tower_stats.attack_interval
		attack_range.size = tower_stats.see_range
	else:
		ready.connect(set_stats.bind(tower_stats))


func shoot(target: Enemy = enemies_in_range[0]) -> void:
	var direction := target.global_position - bullet_spawner.global_position
	var bullet := Bullet.spawn_bullet(50, direction, 10, tower_stats.damage_per_bullet)
	bullet_spawner.add_child.call_deferred(bullet)


func _on_attack_range_enemy_entered(enemy: Enemy) -> void:
	if enemies_in_range.is_empty():
		if attack_interval_timer.is_stopped():
			shoot(enemy)
			attack_interval_timer.start()
	enemies_in_range.append(enemy)


func _on_attack_range_enemy_exited(enemy: Enemy) -> void:
	enemies_in_range.erase(enemy)
	if enemies_in_range.is_empty():
		attack_interval_timer.stop()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("button!")
