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
@onready var hit_particles: CPUParticles2D = $HitParticles
@onready var tower_area_2d: TowerArea2D = $TowerArea2D


func _ready() -> void:
	attack_range.area_entered.connect(_on_attack_range_area_entered)
	attack_range.area_exited.connect(_on_attack_range_area_exited)
	attack_interval_timer.timeout.connect(shoot_if_possible)


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


func shoot_if_possible() -> void:
	if !enemies_in_range.is_empty() and attack_interval_timer.is_stopped():
		shoot()


func shoot(target: Node2D = enemies_in_range[0]) -> void:
	tower_animated_sprite_2d.attack()
	attack_interval_timer.start()
	match tower_stats.attack_shape:
		TowerStats.AttackShape.BULLET:
			var direction := target.global_position - bullet_spawner.global_position
			var bullet := Bullet.spawn_bullet(50, direction, 10, tower_stats.damage_per_bullet, tower_area_2d)
			bullet.position = global_position
			bullet_spawner.add_child.call_deferred(bullet)
		TowerStats.AttackShape.AREA:
			area_attack_visual.attack()
			for enemy in enemies_in_range:
				_hit_enemy(enemy)


func get_hit() -> void:
	hit_particles.emitting = true


func _hit_enemy(enemy: Node2D) -> void:
	match tower_stats.attack_target:
		TowerStats.AttackTarget.ENEMY:
			if not enemy is Enemy: return
			(enemy as Enemy).take_damage(tower_stats.damage_per_bullet)
		TowerStats.AttackTarget.BASE:
			if not enemy is Base: return
			(enemy as Base).take_damage()
		TowerStats.AttackTarget.TOWER:
			if not enemy is Tower: return
			(enemy as Tower).get_hit()


func _on_attack_range_area_entered(area: Area2D) -> void:
	match(tower_stats.attack_target):
		TowerStats.AttackTarget.ENEMY:
			if area is Enemy:
				_on_enemy_entered_range(area as Enemy)
		TowerStats.AttackTarget.TOWER:
			if area is TowerArea2D and area != collision_area:
				_on_enemy_entered_range((area as TowerArea2D).tower)
		TowerStats.AttackTarget.BASE:
			if area is Base:
				_on_enemy_entered_range(area as Base)


func _on_enemy_entered_range(enemy: Node2D) -> void:
	enemies_in_range.append(enemy)
	shoot_if_possible()


func _on_attack_range_area_exited(area: Area2D) -> void:
	match(tower_stats.attack_target):
		TowerStats.AttackTarget.ENEMY:
			if area is Enemy:
				_on_enemy_exited_range(area as Enemy)
		TowerStats.AttackTarget.TOWER:
			if area is TowerArea2D:
				_on_enemy_exited_range((area as TowerArea2D).tower)
		TowerStats.AttackTarget.BASE:
			if area is Base:
				_on_enemy_exited_range(area as Base)


func _on_enemy_exited_range(enemy: Node2D) -> void:
	enemies_in_range.erase(enemy)
