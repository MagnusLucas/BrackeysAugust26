class_name Tower
extends Node2D

@export var tower_stats: TowerStats : set = set_stats
@export var collision_area: Area2D

var enemies_in_range: Array[Node2D]

@onready var attack_range: AttackRange = $AttackRange
@onready var attack_interval_timer: Timer = $AttackIntervalTimer
@onready var bullet_spawner: Node2D = $BulletSpawner
@onready var area_attack_visual: AreaAttackVisual = $AreaAttackVisual
@onready var tower_animated_sprite_2d: TowerAnimatedSprite2D = $TowerAnimatedSprite2D


func _ready() -> void:
	attack_range.area_entered.connect(_on_attack_range_area_entered)
	attack_range.area_exited.connect(_on_attack_range_area_exited)
	attack_interval_timer.timeout.connect(shoot)


func set_stats(value) -> void:
	tower_stats = value
	if !tower_stats:
		return
	if is_node_ready():
		attack_interval_timer.wait_time = tower_stats.attack_interval
		attack_range.size = tower_stats.see_range
		area_attack_visual.set_lifetime(tower_stats.attack_interval * 0.95)
	else:
		ready.connect(set_stats.bind(tower_stats))


func shoot(target: Node2D = enemies_in_range[0]) -> void:
	tower_animated_sprite_2d.attack()
	match tower_stats.attack_shape:
		TowerStats.AttackShape.BULLET:
			var direction := target.global_position - bullet_spawner.global_position
			var bullet := Bullet.spawn_bullet(50, direction, 10, tower_stats.damage_per_bullet)
			bullet_spawner.add_child.call_deferred(bullet)
		TowerStats.AttackShape.AREA:
			area_attack_visual.attack()
			for enemy in enemies_in_range:
				_hit_enemy(enemy)


func _hit_enemy(enemy: Node2D) -> void:
	match tower_stats.attack_target:
		TowerStats.AttackTarget.ENEMY:
			if not enemy is Enemy: return
			(enemy as Enemy).take_damage(tower_stats.damage_per_bullet)
		TowerStats.AttackTarget.BASE:
			if not enemy is Base: return
			#print("ouch, not my base!")
		TowerStats.AttackTarget.TOWER:
			if not enemy is Tower: return
			#print("tower bonked!")


func _on_attack_range_area_entered(area: Area2D) -> void:
	match(tower_stats.attack_target):
		TowerStats.AttackTarget.ENEMY:
			if area is Enemy:
				_on_enemy_entered_range(area as Enemy)
		TowerStats.AttackTarget.TOWER:
			if area is TowerArea2D and area != collision_area:
				_on_tower_entered_range((area as TowerArea2D).tower)
		TowerStats.AttackTarget.BASE:
			if area is Base:
				_on_base_entered_range(area as Base)


func _on_enemy_entered_range(enemy: Enemy) -> void:
	if enemies_in_range.is_empty():
		if attack_interval_timer.is_stopped():
			shoot(enemy)
			attack_interval_timer.start()
	enemies_in_range.append(enemy)


func _on_tower_entered_range(tower: Tower) -> void:
	if enemies_in_range.is_empty():
		if attack_interval_timer.is_stopped():
			shoot(tower)
			attack_interval_timer.start()
	enemies_in_range.append(tower)


func _on_base_entered_range(base: Base) -> void:
	if attack_interval_timer.is_stopped():
		shoot(base)
		attack_interval_timer.start()
	enemies_in_range.append(base)


func _on_attack_range_area_exited(area: Area2D) -> void:
	match(tower_stats.attack_target):
		TowerStats.AttackTarget.ENEMY:
			if area is Enemy:
				_on_enemy_exited_range(area as Enemy)
		TowerStats.AttackTarget.TOWER:
			if area is TowerArea2D:
				_on_tower_exited_range((area as TowerArea2D).tower)
		TowerStats.AttackTarget.BASE:
			if area is Base:
				_on_base_exited_range(area as Base)


func _on_enemy_exited_range(enemy: Enemy) -> void:
	enemies_in_range.erase(enemy)
	if enemies_in_range.is_empty():
		attack_interval_timer.stop()


func _on_tower_exited_range(tower: Tower) -> void:
	enemies_in_range.erase(tower)
	if enemies_in_range.is_empty():
		attack_interval_timer.stop()


func _on_base_exited_range(base: Base) -> void:
	enemies_in_range.erase(base)
	attack_interval_timer.stop()
